module QuakeliveApi
  class Profile
    class Statistics < ::QuakeliveApi::Base
      attr_reader :weapons, :records

      private

        def url
          "/profile/statistics/#{player_name}"
        end

        def setup_variables
          @weapons = parser.weapons
          @records = parser.records
        end
    end
  end
end
