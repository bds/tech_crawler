module TechCrawler
  class Crawler
    attr_reader :domains, :hydra, :config, :logger

    def initialize(domains, logger, config: Configuration.new)
      @domains = domains
      @logger  = logger
      @config  = config
      @hydra   = Typhoeus::Hydra.new(max_concurrency: 20)
    end

    def call!
      domains.each do |domain|
        Request.new(domain, hydra, config, logger).call
      end

      hydra.run
    end
  end
end
