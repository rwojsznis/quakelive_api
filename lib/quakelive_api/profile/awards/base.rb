module QuakeliveApi
  class Profile
    module Awards
      class Base < ::QuakeliveApi::Base

        attr_accessor :earned, :unearned

        private

          def common_url
            "/profile/awards/#{player_name}"
          end

          def setup_variables
            @earned   = parser.earned
            @unearned = parser.unearned
          end
      end
    end
  end
end
