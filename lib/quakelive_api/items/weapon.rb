module QuakeliveApi
  module Items
    class Weapon < Struct.new(:name, :frags, :accuracy, :hits, :shots, :usage)
      include Structurable
    end
  end
end
