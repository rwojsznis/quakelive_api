module QuakeliveApi
  module Parser
    class Summary < Base
      selector :country,     ".playername img"
      selector :nick,        "#prf_player_name"
      selector :clan,        ".playername a.clan"
      selector :model,       ".prf_imagery div"
      selector :vitals,      ".prf_vitals p"
      selector :member,      "b:contains('Member Since')"
      selector :last,        "b:contains('Last Game') + span"
      selector :played,      "b:contains('Time Played') + span"
      selector :wins,        "b:contains('Wins')"
      selector :losses,      "b:contains('Losses')"
      selector :frags,       "b:contains('Frags')"
      selector :hits,        "b:contains('Hits')"
      selector :accuracy,    "b:contains('Accuracy')"
      selector :favs,        ".prf_faves b"
      selector :awards,      ".prf_awards .awd_details"
      selector :games,       ".recent_match"
      selector :competitors, "#qlv_profileBottomInset .rcmp_block"

      def country
        document.at(selector(:country))['title']
      end

      def nick
        document.at(selector(:nick)).text
      end

      def clan
        (c = document.at(selector(:clan))) ? c.text : nil
      end

      def model
        div = document.at(selector(:model))
        name  = div['title']
        image = decode_background(div['style'])
        Model.new(name, image)
      end

      def member_since
        Date.parse vitals.at(selector(:member)).next.text.match(/([\w.\s,]+)/)[1]
      end

      def last_game
        node = vitals.at selector(:last)
        node ? decode_time(node['title']) : nil
      end

      def time_played
        node = vitals.at selector(:played)
        node ? GameTime.new(node['title']) : nil
      end

      def wins
        to_integer vitals.at(selector(:wins)).next.text
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
        Favourite.new *document.css(selector(:favs))
          .map { |n| n.next.text.strip }
          .map { |n| n == "None" ? nil : n }
      end

      def awards
        awards = document.css(selector(:awards)).map do |node|
          title = node.at('.vcenter_data b')
          next if title.text =~ /No recent award/

          info        = node['title']
          icon        = node.at('img')['src']
          awarded     = title.next.next
          description = awarded.next.next

          Award.new(icon, info, title.text.strip, awarded.text.strip, description.text.strip.gsub("\n",""))
        end.compact

        awards.any? ? awards : nil
      end

      def recent_games
        games = document.css(selector(:games)).map do |node|
          gametype = decode_gametype node.at('img.gametype')['src']
          finish   = node.at('span.finish').text.strip.match(/Finish:\s+(\w+)/i)[1]
          played   = node.at('span.played').text.strip.match(/Played:\s+([\w\d ]+)/i)[1]
          image    = node.at('img.levelshot')['src']

          RecentGame.new(gametype, finish, played, image)
        end.compact

        games.any? ? games : nil
      end

      def recent_competitors
        competitors = document.css(selector(:competitors)).map do |node|
          next if node.at('.rcmp_none')

          icon   = decode_background node.at('.usericon_standard_lg')['style']
          nick   = node.at('a.player_nick_dark').text
          played = decode_time(node.at('span.text_tooltip')['title'])

          Competitor.new(icon, nick, played )
        end.compact

        competitors.any? ? competitors : nil
      end

      private

      def decode_time(string)
        Time.strptime(string, '%m/%d/%Y %H:%M %p')
      end

      def decode_gametype(string)
        if string =~ /ca_/
          'CA'
        elsif string =~ /tdm_/
          'TDM'
        end
      end

      def decode_background(string)
        string.strip.match(/background(?:-image)?: url\(([\w\d:\/.]+)/)[1]
      end

      def vitals
        document.at(selector(:vitals))
      end

      def parse_slashed(node)
        match = node.next.text.match /([\d,]+) \/ ([\d,]+)/
        [match[1], match[2]].map { |r| to_integer(r) }
      end

      def to_integer(val)
        val.gsub(',','').to_i
      end

    end
  end
end
