module QuakeliveApi
  module Items
    class Competitor < Struct.new(:icon, :nick, :played)
      include Structurable
    end
  end
end
