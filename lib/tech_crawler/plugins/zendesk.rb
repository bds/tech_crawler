module TechCrawler
  class Zendesk < Plugin
    def call
      has_matching_cookies?
    end

    def has_matching_cookies?
      cookies = *response.headers['Set-Cookie']

      cookies.any? { |cookie| /zendesk/ === cookie }
    end

    def self.path
      '/help'
    end
  end
end
