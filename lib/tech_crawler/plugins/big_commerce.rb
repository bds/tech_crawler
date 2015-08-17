module TechCrawler
  class BigCommerce < Plugin
    def call
      has_matching_cookies?
    end

    def has_matching_cookies?
      cookies = *response.headers['Set-Cookie']

      matches = cookies.count do |cookie|
        /^fornax_anonymousId=+|^SHOP_SESSION_TOKEN=+/ === cookie
      end

      matches == 2
    end
  end
end
