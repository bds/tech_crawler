module TechCrawler
  class Shopify < Plugin
    def call
      has_matching_header?
    end

    def has_matching_header?
      /\d+/ === response.headers['X-Sorting-Hat-ShopId']
    end
  end
end
