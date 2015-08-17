module TechCrawler
  class Desk < Plugin
    def call
      has_matching_html?
    end

    def has_matching_html?
      /sfdc|\bdesk.com\b/ === response.body
    end

    def self.path
      '/help'
    end
  end
end
