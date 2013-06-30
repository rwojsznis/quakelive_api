module QuakeliveApi
  module Parser
    class Summary < Base
      selector :country,  ".playername img"
      selector :profile,  "#prf_player_name"
      selector :clan,     ".playername a.clan"
      selector :model,    ".prf_imagery div"
      selector :vitals,   ".prf_vitals p"
      selector :member,   "b:contains('Member Since')"
      selector :last,     "b:contains('Last Game') + span"
      selector :played,   "b:contains('Time Played') + span"
      selector :wins,     "b:contains('Wins')"
      selector :losses,   "b:contains('Losses')"
      selector :frags,    "b:contains('Frags')"
      selector :hits,     "b:contains('Hits')"
      selector :accuracy, "b:contains('Accuracy')"

      def country
        document.at(selector(:country))['title']
      end

      def profile_name
        document.at(selector(:profile)).text
      end

      def clan_name
        (clan = document.at(selector(:clan))) ? clan.text : nil
      end

      def model
        document.at(selector(:model))['title']
      end

      def member_since
        Date.parse vitals.at(selector(:member)).next.text.match(/([\w.\s,]+)/)[1]
      end

      def last_game
        node = vitals.at selector(:last)
        node ? Time.strptime(node['title'], '%m/%d/%Y %H:%M %p') : nil
      end

      def time_played
        node = vitals.at selector(:played)
        node ? GameTime.new(node['title']) : nil
      end

      def wins
        vitals.at(selector(:wins)).next.text.to_i
      end

      def accuracy
        vitals.at(selector(:accuracy)).next.text.match(/([\d.]+)%/)[1].to_f
      end

      def losses_quits
        parse_slashed vitals.at(selector(:losses))
      end

      def frags_deaths
        parse_slashed vitals.at(selector(:frags))
      end

      def hits_shots
        parse_slashed vitals.at(selector(:hits))
      end

      def favourites
        document.css('.prf_faves b').map { |n| n.next.text.strip }
      end

      private

      def vitals
        document.at(selector(:vitals))
      end

      def parse_slashed(node)
        match = node.next.text.match /(\d+) \/ (\d+)/
        [ match[1].to_i, match[2].to_i ]
      end

    end
  end
end
