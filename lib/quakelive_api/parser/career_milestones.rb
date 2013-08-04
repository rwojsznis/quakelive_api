module QuakeliveApi
  module Parser
    class CareerMilestones < Base
      @selectors = {
        :earned   => ".detailArea",
        :unearned => ".detailArea_off"
      }

      def earned
        if earned = document.css(selector(:earned))
          earned.map { |node| parse_node(node) }
        end
      end

      def unearned
        document.css(selector(:unearned)).map { |node| parse_node(node) }
      end

      private

      def parse_node(node)
        attrs = {
          :icon => node.at('img')['src'],
          :info => node.at('img')['title'],
          :name => node.at('span.bigRedTxt').content,
          :description => node.at('span.blktxt_11').content,
          :awarded => awarded_at(node)
        }
        Items::Award.new(attrs)
      end

      def awarded_at(node)
        return unless node.css('ul.fl li').count >= 3
        matches = node.at('ul.fl li:first-child').content.match(/(\d{2})\/(\d{2})\/(\d{4})/)
        Date.new(matches[3].to_i, matches[1].to_i, matches[2].to_i)
      end

    end
  end
end
