#             Played | Finished | Wins | Quits | Completed | Wins
# Clan Arena 13 13 7 0 100% 54%
# Capture The Flag 74 67 39 7 91% 53%
# Free For All 31 27 10 4 87% 32%
# Domination 16 16 11 0 100% 69%
# Freeze Tag 1 0 0 1 0% 0%
# Team Death Match 155 142 79 13 92% 51%
# Duel 530 501 209 29 95% 39%
# Total

# Frags Accuracy Use
# Gauntlet 185 N/A 1%
# Machinegun 1,232 29% (tooltip: hits/shots) 9%

# weapons - Array[]
# WeaponStruct < (:name, :frags, :accuracy, :hits, :shots, :usage)

module QuakeliveApi
  module Parser
    class Statistics < Base
      selector :weapon,      ".prf_weapons .col_weapon"
      selector :frags,       ".col_frags"
      selector :accuracy,    ".col_accuracy"
      selector :usage,       ".col_usage"
      selector :record,      ".qlv_profile_section_statistics .prf_record > div"

      def weapons
        document.css(selector(:weapon)).each_with_index.map do |node, idx|
          attrs = {
            :name     => node.text,
            :frags    => frags(weapon_next(:frags, idx)),
            :accuracy => accuracy(weapon_next(:accuracy, idx)),
            :usage    => usage(weapon_next(:usage, idx))
          }

          hits, shots = hits_shots(weapon_next(:accuracy, idx))
          attrs.merge!(:hits => hits, :shots => shots)

          Items::Weapon.new(attrs)
        end
      end

      def records
        document.css(selector(:record)).map do |node|
          attrs = {
            :title     => node.at('.col_st_gametype').text.strip,
            :played    => to_integer(node.at('.col_st_played').text),
            :finished  => to_integer(node.at('.col_st_finished').text),
            :wins      => to_integer(node.at('.col_st_wins').text),
            :quits     => to_integer(node.at('.col_st_withdraws').text),
            :completed => to_integer(node.at('.col_st_completeperc').text.gsub('%','')),
            :wins_percentage => to_integer(node.at('.col_st_winperc').text.gsub('%',''))
          }
          Items::Record.new(attrs)
        end
      end

      private

      def hits_shots(node)
        return nil,nil unless node['title']
        res = node['title'].match /Hits: ([\d,]+) Shots: ([\d,]+)/
        [res[1], res[2]].map { |r| to_integer r}
      end

      def usage(node)
        to_integer node.text.gsub("%", '')
      end

      def weapon_next(css, index)
        document.css(".prf_weapons #{selector(css)}")[index]
      end

      def frags(node)
        to_integer node.text
      end

      def accuracy(node)
        return if node.text == 'N/A'
        to_integer node.at('span').text.gsub("%","")
      end
    end
  end
end
