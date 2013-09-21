module QuakeliveApi
  class GameTime
    attr_accessor :ranked, :unranked

    class Interval < Struct.new(:seconds, :minutes, :hours, :days)
      def total
        members.sum { |m| send(m).send(m) } # see what I did there?
      end
    end

    # accepts unparsed string directly from QL profile, for example:
    # * Ranked Time: 21:50 Unranked Time: 04:54
    # * Ranked Time: 50.06:18:30 Unranked Time: 02:31:02
    def initialize(unparsed_string)
      matches = unparsed_string.match(/Ranked Time: ([\d:.]+) Unranked Time: ([\d:.]+)/)
      return unless matches

      @ranked   = reverse_match(matches[1])
      @unranked = reverse_match(matches[2])
    end

    def ==(other)
      return ranked == other.ranked && unranked == other.unranked
    end

    private

      def reverse_match(string)
        attrs = string.split(/\.|:/).reverse.map { |a| a.to_i }
        (4 - attrs.size).times { attrs << 0 }
        Interval.new(*attrs)
      end
  end
end
