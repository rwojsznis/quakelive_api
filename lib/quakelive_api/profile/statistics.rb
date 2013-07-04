module QuakeliveApi
  class Profile
    class Statistics < ::QuakeliveApi::Base
      attr_reader :weapons

      private

      def url
        "/profile/statistics/#{player_name}"
      end

      def setup_variables
        @weapons = parser.weapons
      end

    end
  end
end
