module QuakeliveApi
  module Items
    class Record < Struct.new(:title, :played, :finished, :wins, :quits, :completed, :wins_percentage)
      include Structurable
    end
  end
end
