module QuakeliveApi
  module Parser
    class Statistics < Base

      def weapons
        document.css(selector(:weapon)).each_with_index.map do |node, idx|
          next if node.children.empty? # messed-up html by id, thanks

          attrs = {
            name:     next_element(:name, idx).content,
            frags:    frags(next_element(:frags, idx)),
            accuracy: accuracy(next_element(:accuracy, idx)),
            usage:    usage(next_element(:usage, idx))
          }

          hits, shots = hits_shots(next_element(:accuracy, idx))
          attrs.merge!(hits: hits, shots: shots)

          Items::Weapon.new(attrs)
        end
      end

      def records
        return if no_records?

        document.css(selector(:record)).map do |node|

          next if no_records?

          attrs = {
            title:           node.at('.col_st_gametype').text.strip,
            played:          to_integer(node.at('.col_st_played').text),
            finished:        to_integer(node.at('.col_st_finished').text),
            wins:            to_integer(node.at('.col_st_wins').text),
            quits:           to_integer(node.at('.col_st_withdraws').text),
            completed:       to_integer(node.at('.col_st_completeperc').text.gsub('%','')),
            wins_percentage: to_integer(node.at('.col_st_winperc').text.gsub('%',''))
          }
          Items::Record.new(attrs)
        end
      end

      private

      def selectors
        {
          weapon:   ".prf_weapons p",
          name:     ".col_weapon",
          frags:    ".col_frags",
          accuracy: ".col_accuracy",
          usage:    ".col_usage",
          record:   ".qlv_profile_section_statistics .prf_record > div"
        }
      end

      def no_records?
        document.at(selector(:record)).nil?
      end

      # 71,259 / 247,016 (28.85%)
      def hits_shots(node)
        return [nil, nil] unless node['title']

        selector = if node['title'] =~ /hits/i
          /Hits: ([\d,]+) Shots: ([\d,]+)/i
        else
          /([\d,]+)\s+\/\s+([\d,]+)/i
        end

        res = node['title'].match(selector)

        [res[1], res[2]].map { |r| to_integer r }
      end

      def usage(node)
        to_integer node.text.gsub(/%|,/, '')
      end

      def next_element(css, index)
        document.css(".prf_weapons #{selector(css)}")[index]
      end

      def frags(node)
        to_integer node.text
      end

      def accuracy(node)
        return if node.text =~ /^n\/a$/i
        to_integer node.at('span').text.gsub("%","")
      end
    end
  end
end
