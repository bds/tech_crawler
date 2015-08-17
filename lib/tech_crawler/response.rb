module TechCrawler
  PluginResult = Struct.new(:domain, :plugin, :tech_detected?)

  class Response
    attr_reader :domain, :response, :plugins, :logger

    def initialize(domain, response, plugins, logger)
      @domain = domain
      @response = response
      @plugins = plugins
      @logger = logger
    end

    def call
      if response.success?
        call_plugins
      elsif response.timed_out?
        logger.warn("HTTP request to #{domain} got a time out")
      elsif response.code == 0
        logger.fatal("HTTP request to #{domain} failed")
      else
        logger.error("HTTP request to #{domain} failed: " + response.code.to_s)
      end
    end

    def call_plugins
      plugins.map do |plugin|
        tech_detected = plugin.new(response).call

        output_plugin_result_info(plugin, tech_detected)

        PluginResult.new(domain, plugin, tech_detected)
      end
    end

    def output_plugin_result_info(plugin, tech_detected)
      logger.info(
        [
          domain,
          response.request.url,
          response.effective_url,
          plugin,
          tech_detected
        ].join(", ")
      )
    end
  end
end
