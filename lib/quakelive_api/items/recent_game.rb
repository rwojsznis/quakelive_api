module QuakeliveApi
  module Items
    class RecentGame < Struct.new(:gametype, :finish, :played, :image)
      include Structurable
    end
  end
end
