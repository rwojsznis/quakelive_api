module QuakeliveApi
  module Parser
    class Summary < Base

      def country
        document.at(selector(:country))['title']
      end

      def nick
        document.at(selector(:nick)).xpath('text()').text.strip
      end

      def clan
        clan_tag = document.at(selector(:clan))
        clan_tag.text if clan_tag
      end

      def model
        div = document.at(selector(:model))
        name  = div['title']
        image = decode_background(div['style'])
        Items::Model.new(name, image)
      end

      def member_since
        Date.parse vitals.at(selector(:member)).next.text.match(/([\w.\s,]+)/)[1]
      end

      def last_game
        node = vitals.at selector(:last)
        decode_time(node['title']) if node
      end

      def time_played
        node = vitals.at selector(:played)
        GameTime.new(node['title']) if node
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
        Items::Favourite.new(*document.css(selector(:favs))
          .map { |n| n.next.text.strip }
          .map { |n| n == "None" ? nil : n })
      end

      def awards
        awards = document.css(selector(:awards)).map do |node|
          title = node.at('.vcenter_data b')

          next if title.text =~ /No recent award/

          info        = node['title']
          icon        = node.at('img')['src']
          awarded     = title.next.next
          description = awarded.next.next

          Items::Award.new(icon, info, title.text.strip, awarded.text.strip, description.text.strip.gsub("\n",""))
        end.compact

        awards.any? ? awards : nil
      end

      def recent_games
        games = document.css(selector(:games)).map do |node|
          gametype = decode_gametype node.at('img.gametype')['src']
          finish   = node.at('span.finish').text.strip.match(/Finish:\s+(\w+)/i)[1]
          played   = node.at('span.played').text.strip.match(/Played:\s+([\w ]+)/i)[1]
          image    = node.at('img.levelshot')['src']

          Items::RecentGame.new(gametype, finish, played, image)
        end.compact

        games if games.any?
      end

      def recent_competitors
        competitors = document.css(selector(:competitors)).map do |node|
          next if node.at('.rcmp_none')

          icon   = decode_background node.at('.usericon_standard_lg')['style']
          nick   = node.at('a.player_nick_dark').xpath('child::text()').to_s
          played = decode_time(node.at('span.text_tooltip')['title'])

          Items::Competitor.new(icon, nick, played )
        end.compact

        competitors if competitors.any?
      end

      private

      def selectors
        {
          country:     "img.playerflag",
          nick:        ".profile_title",
          clan:        ".profile_title a.clan",
          model:       ".prf_imagery div",
          vitals:      ".prf_vitals p",
          member:      "b:contains('Member Since')",
          last:        "b:contains('Last Game') + span",
          played:      "b:contains('Time Played') + span",
          wins:        "b:contains('Wins')",
          losses:      "b:contains('Losses')",
          frags:       "b:contains('Frags')",
          hits:        "b:contains('Hits')",
          accuracy:    "b:contains('Accuracy')",
          favs:        ".prf_faves b",
          awards:      ".prf_awards .awd_details",
          games:       ".recent_match",
          competitors: "#qlv_profileBottomInset .rcmp_block"
        }.freeze
      end

      def decode_time(string)
        Time.strptime(string, '%m/%d/%Y %H:%M %p')
      end

      # FIXME: not really fully implemented
      def decode_gametype(string)
        if string =~ /ca_/
          'CA'
        elsif string =~ /tdm_/
          'TDM'
        elsif string =~ /ctf_/
          'CTF'
        elsif string =~ /duel_/
          'Duel'
        elsif string =~ /ad_/
          'Attack&Defend'
        elsif string =~ /ffa_/
          'FFA'
        elsif string =~ /ft_/
          'FreezeTag'
        elsif string =~ /race_/
          'Race'
        elsif string =~ /rr_/
          'Red Rover'
        end
      end

      def decode_background(string)
        string.strip.match(/background(?:-image)?: url\(([\w:\/.]+)/)[1]
      end

      def vitals
        document.at(selector(:vitals))
      end

      def parse_slashed(node)
        match = node.next.text.match(/([\d,]+) \/ ([\d,]+)/)
        [match[1], match[2]].map { |r| to_integer(r) }
      end

    end
  end
end
