module TechCrawler
  class Configuration
    ATTRIBUTES = [
      :followlocation, :accept_encoding, :timeout, :headers, :cookiejar,
        :ssl_verifyhost, :verbose
    ]

    attr_reader *ATTRIBUTES

    def initialize(attrs = {})
      @followlocation = attrs.fetch(:followlocation) { true }
      @accept_encoding = attrs.fetch(:accept_encoding) { 'gzip' }
      @timeout = attrs.fetch(:timout) { 10 }
      @ssl_verifyhost = attrs.fetch(ssl_verifyhost) { 0 }
      @headers = attrs.fetch(:headers) do
        {
          'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:39.0) Gecko/20100101 Firefox/39.0'
        }
      end
      @cookiejar = attrs.fetch(:cookiejar) { './cookies' }
      @verbose = attrs.fetch(:verbose) { false }
    end

    def attributes
      ATTRIBUTES.each_with_object({}) do |el, memo|
        memo[el] = send(el)
      end
    end
  end
end
