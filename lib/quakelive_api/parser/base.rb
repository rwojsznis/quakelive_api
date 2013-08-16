module QuakeliveApi
  module Parser
    class Base
      def initialize(document)
        @document = document
      end

      def invalid_player?
        document.css('.prf_header span').text =~ /Player not found/
      end

      def request_error?
        document.css('#sorry_content p:first-child').text =~ /An error has occurred while handling your request/
      end

      private

      attr_reader :document

      def selectors
        raise NotImplementedError
      end

      def selector(name)
        selectors.fetch(name)
      end

      def to_integer(val)
        val.gsub(',','').to_i
      end
    end
  end
end
