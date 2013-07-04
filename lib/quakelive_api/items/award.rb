module QuakeliveApi
  module Items
    class Award < Struct.new(:icon, :info, :name, :awarded, :description)
      include Structurable
    end
  end
end
