module QuakeliveApi
  module Items
    class Favourite < Struct.new(:arena, :game_type, :weapon)
      include Structurable
    end
  end
end
