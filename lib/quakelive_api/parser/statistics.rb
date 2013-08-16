module QuakeliveApi
  module Parser
    class Statistics < Base

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
        return if no_records?

        document.css(selector(:record)).map do |node|

          next if no_records?

          attrs = {
            :title           => node.at('.col_st_gametype').text.strip,
            :played          => to_integer(node.at('.col_st_played').text),
            :finished        => to_integer(node.at('.col_st_finished').text),
            :wins            => to_integer(node.at('.col_st_wins').text),
            :quits           => to_integer(node.at('.col_st_withdraws').text),
            :completed       => to_integer(node.at('.col_st_completeperc').text.gsub('%','')),
            :wins_percentage => to_integer(node.at('.col_st_winperc').text.gsub('%',''))
          }
          Items::Record.new(attrs)
        end
      end

      private

      def selectors
        {
          :weapon   => ".prf_weapons .col_weapon",
          :frags    => ".col_frags",
          :accuracy => ".col_accuracy",
          :usage    => ".col_usage",
          :record   => ".qlv_profile_section_statistics .prf_record > div"
        }
      end

      def no_records?
        document.at(selector(:record)).nil?
      end

      def hits_shots(node)
        return [nil, nil] unless node['title']
        res = node['title'].match(/Hits: ([\d,]+) Shots: ([\d,]+)/)
        [res[1], res[2]].map { |r| to_integer r }
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
