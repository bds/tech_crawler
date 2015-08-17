module TechCrawler
  class Request
    attr_reader :domain, :config, :logger

    def initialize(domain, hydra, config, logger)
      @domain = domain
      @hydra = hydra
      @config = config
      @logger = logger
    end

    def call
      crawl_domain(domain, Plugin.plugins)
    end

    # Attempts to detect as many technolgies as possible on the first
    # request to the root path of the domain, ex. Cookies, Headers.
    #
    # Initially for a given domain it will generate 1 request whose response
    # will be processed by all plugins
    #
    # If a technology/plugin is not detected on the root path of the domain
    # an additional request is generated for each plugin that responds to path
    #
    def crawl_domain(domain, plugins)
      request = Typhoeus::Request.new(domain, config.attributes)

      request.on_success do |response|
        domain_crawl_results = Response.new(domain, response, plugins, logger).call

        plugins_not_detected = domain_crawl_results.reduce([]) do |memo, el|
          memo << el.plugin if !el.tech_detected? && el.plugin.respond_to?(:path)
          memo
        end

        crawl_path(domain, plugins_not_detected)
      end

      @hydra.queue(request)
    end

    # For a given domain it will generates at most 1 request *per* plugin/path
    #
    # If domain/path fails for one plugin, we should stop crawling that path.
    #
    def crawl_path(domain, plugins)
      probe_plugin = plugins.pop
      probe_path = domain + probe_plugin.path
      probe_request = Typhoeus::Request.new(probe_path, config.attributes)

      @hydra.queue(probe_request)

      probe_request.on_success do |probe_response|
        Response.new(domain, probe_response, Array(probe_plugin), logger).call

        plugins.each do |plugin|
          path = domain + plugin.path
          path_request = Typhoeus::Request.new(path, config.attributes)

          path_request.on_complete do |response|
            Response.new(domain, response, Array(plugin), logger).call
          end

          @hydra.queue(path_request)
        end
      end
    end
  end
end
