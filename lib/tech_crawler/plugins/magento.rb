module TechCrawler
  class Magento < Plugin
    def call
      has_matching_cookies?
    end

    def has_matching_cookies?
      cookies = *response.headers['Set-Cookie']

      cookies.any? { |cookie| /^frontend=[0-9a-z]+/ === cookie }
    end
  end
end
