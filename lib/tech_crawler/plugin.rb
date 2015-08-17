module TechCrawler
  class Plugin
    attr_reader :response

    def initialize(response)
      @response = response
    end

    # Child plugins respond with true || false
    def call
      raise NotImplementedError
    end

    class << self
      def plugins
        @plugins ||= []
      end

      def inherited(klass)
        @plugins ||= []

        @plugins << klass
      end
    end
  end
end
