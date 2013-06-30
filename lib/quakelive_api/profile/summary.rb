module QuakeliveApi
  class Profile
    class Summary < ::QuakeliveApi::Base
      attr_reader :country, :profile_name, :clan_name, :model, :member_since,
                  :last_game, :time_played, :wins, :losses, :quits, :frags,
                  :deaths, :hits, :shots, :accuracy, :favourite, :recent_awards,
                  :recent_games

      private

      def url
        "/profile/summary/#{player_name}"
      end

      def setup_variables
        @country        = parser.country
        @profile_name   = parser.profile_name
        @clan_name      = parser.clan_name
        @model          = parser.model
        @member_since   = parser.member_since
        @last_game      = parser.last_game
        @time_played    = parser.time_played
        @wins           = parser.wins
        @accuracy       = parser.accuracy
        @losses, @quits = parser.losses_quits
        @frags, @deaths = parser.frags_deaths
        @hits, @shots   = parser.hits_shots
        @favourite      = parser.favourites
        @recent_awards  = parser.awards
        @recent_games   = parser.recent_games
      end

    end
  end
end
