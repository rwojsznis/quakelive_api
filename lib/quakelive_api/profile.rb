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

    def awards_milestones
      @awards_milestones ||= Awards::CareerMilestones.new(player_name)
    end

    def awards_experience
      @awards_experience ||= Awards::Experience.new(player_name)
    end

    def awards_skillz
      @awards_skillz ||= Awards::MadSkillz.new(player_name)
    end

    def awards_social
      @awards_social ||= Awards::SocialLife.new(player_name)
    end

    def awards_success
      @awards_success ||= Awards::SweetSuccess.new(player_name)
    end

    def each_award(&block)
      %w(awards_milestones awards_experience awards_skillz awards_social awards_success).each do |awards|
        block.call(send(awards))
      end
    end

  end
end
