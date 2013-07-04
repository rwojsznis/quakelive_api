module QuakeliveApi
  module Parser
    class Base
      def initialize(document)
        @document = document
      end

      def self.selector(name, css_selector)
        @selectors ||= {}
        @selectors[name] = css_selector
      end

      def self.selectors
        @selectors ||= {}
      end

      def invalid_player?
        document.css('.prf_header span').text =~ /Player not found:/
      end

      def request_error?
        document.css('#sorry_content p:first-child').text =~ /An error has occurred while handling your request/
      end

      private

      attr_reader :document

      def selector(name)
        self.class.selectors[name]
      end

      def to_integer(val)
        val.gsub(',','').to_i
      end
    end
  end
end
