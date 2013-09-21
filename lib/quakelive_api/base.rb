module QuakeliveApi
  class Base
    attr_accessor :player_name

    def initialize(player_name)
      @player_name = player_name

      set_parser Nokogiri::HTML(get)
      setup_variables!
    end

    def inspect
      "#{self.class}:#{object_id}\n" + instance_variables.map do |v|
        next if v.to_s == "@parser"
        "#{v}=#{instance_variable_get(v).inspect}"
      end.compact.join("\n")
    end

    private

      def get
        Net::HTTP.get(URI.parse(URI::encode("#{QuakeliveApi.site}#{url}")))
      end

      def url
        raise NotImplementedError
      end

      def parser
        @parser
      end

      def set_parser(document)
        @parser ||= ::QuakeliveApi::Parser.const_get(self.class.class_name).new(document)
      end

      def self.class_name
        name.split('::').last
      end

      def setup_variables!
        raise Error::PlayerNotFound if parser.invalid_player?
        raise Error::RequestError   if parser.request_error?

        setup_variables
      end

      def setup_variables
        raise NotImplementedError
      end
  end
end
