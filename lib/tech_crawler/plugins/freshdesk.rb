module TechCrawler
  class Freshdesk < Plugin
    def call
      has_matching_html?
    end

    def has_matching_html?
      /freshdesk/ ===  response.body
    end

    def self.path
      '/help'
    end
  end
end
