module QuakeliveApi
  class Profile
    attr_accessor :player_name

    def initialize(player_name)
      @player_name = player_name
    end

    def summary
      @summary ||= Summary.new(player_name)
    end

    def statistics
      @statistics ||= Statistics.new(player_name)
    end

  end
end
