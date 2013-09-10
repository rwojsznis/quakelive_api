module QuakeliveApi
  module Parser
    class Awards < Base

      def earned
        awards = document.css(selector(:earned))
        if awards
          awards.map { |node| parse_node(node) }
        end
      end

      def unearned
        document.css(selector(:unearned)).map { |node| parse_node(node) }
      end

      private

      def selectors
        {
          :earned   => ".detailArea",
          :unearned => ".detailArea_off"
        }
      end

      def parse_node(node)
        attrs = {
          :icon => node.at('img')['src'],
          :info => node.at('img')['title'],
          :name => node.at('span.bigRedTxt').content,
          :description => node.at('span.blktxt_11').content,
          :awarded => awarded_at(node)
        }
        Items::Award.new(attrs)
        rescue NoMethodError => e
          raise "#{e.inspect} | DOCUMENT: #{@document.to_s}"
      end

      def awarded_at(node)
        return unless node.css('ul.fl li').count >= 3

        matches = node.at('ul.fl li:first-child').content.match(/(\d{2})\/(\d{2})\/(\d{4})/)
        Date.new(matches[3].to_i, matches[1].to_i, matches[2].to_i) unless matches.nil?
      end
    end

    class CareerMilestones < Awards; end
    class Experience < Awards; end
    class MadSkillz < Awards; end
    class SocialLife < Awards; end
    class SweetSuccess < Awards; end
  end
end
