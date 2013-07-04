module QuakeliveApi
  module Items
    class Model < Struct.new(:name, :image)
      include Structurable
    end
  end
end
