require "test_helper"

describe "Game time conversion" do

  before { @game_time = QuakeliveApi::GameTime.new(string) }

  describe "parses periods without days" do
    let(:string) { "Ranked Time: 21:50 Unranked Time: 04:54" }

    describe "ranked time" do
      subject { @game_time.ranked }

      its(:days)    { must_equal 0 }
      its(:hours)   { must_equal 0 }
      its(:minutes) { must_equal 21 }
      its(:seconds) { must_equal 50 }
    end

    describe "unranked time" do
      subject { @game_time.unranked }

      its(:days)    { must_equal 0 }
      its(:hours)   { must_equal 0 }
      its(:minutes) { must_equal 4 }
      its(:seconds) { must_equal 54 }
    end
  end

  describe "parses periods with days" do
    let(:string) { "Ranked Time: 50.06:18:30 Unranked Time: 02:31:02" }

    describe "ranked time" do
      subject { @game_time.ranked }

      its(:days)    { must_equal 50 }
      its(:hours)   { must_equal 6 }
      its(:minutes) { must_equal 18 }
      its(:seconds) { must_equal 30 }
    end

    describe "unranked time" do
      subject { @game_time.unranked }

      its(:days)    { must_equal 0 }
      its(:hours)   { must_equal 2 }
      its(:minutes) { must_equal 31 }
      its(:seconds) { must_equal 02 }
    end
  end

end
