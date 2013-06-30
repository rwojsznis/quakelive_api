module QuakeliveApi
  class Profile
    class Statistics < ::QuakeliveApi::Base

      private

      def url
        "/profile/statistics/#{player_name}"
      end

      def setup_variables

      end

    end
  end
end
