require "test_helper"

describe "QuakeliveApi::Profile::Statistics" do
  make_my_diffs_pretty!()

  describe "black box test for" do
    before  { stub_stats_request(profile, fixture_statistics(profile)) }
    subject { QuakeliveApi::Profile::Statistics.new(profile) }

    describe "xsi" do
      let(:profile) { "xsi" }

      it "fetches proper stats for weapons" do
        [
          ['Gauntlet', 185, nil, nil, nil, 1],
          ['Machinegun', 1232, 29, 64240, 224939, 9],
          ['Shotgun', 2091, 27, 25170, 91613, 9],
          ['Grenade Launcher', 241, 10, 1379, 14099, 3],
          ['Rocket Launcher', 4024, 34, 28089, 82907, 39],
          ['Lightning Gun', 2043, 28, 84078, 303670, 15],
          ['Railgun', 2357, 38, 8295, 21857, 19],
          ['Plasma Gun', 708, 13, 10248, 77616, 5],
          ['BFG', 4, 49, 26, 53, 0],
          ['Chaingun', 37, 21, 1111, 5358, 0],
          ['Nailgun', 18, 13, 466, 3495, 0],
          ['Proximity Mine', 7, 24, 40, 164, 0]
        ].each_with_index do |weapon, index|
          assert_equal subject.weapons[index], QuakeliveApi::Items::Weapon.new(*weapon)
        end
      end

      it "fetches proper stats for records" do
        [
          ['Clan Arena', 13, 13, 7, 0, 100, 54],
          ['Capture The Flag', 74, 67, 39, 7, 91, 53],
          ['Free For All', 31, 27, 10, 4, 87, 32],
          ['Domination', 16, 16, 11, 0, 100, 69],
          ['Freeze Tag', 1, 0, 0, 1, 0, 0],
          ['Team Death Match', 155, 142, 79, 13, 92, 51],
          ['Duel', 530, 501, 209, 29, 95, 39],
          ['Total', 820, 766, 355, 54, 93, 43]
        ].each_with_index do |record, index|
          assert_equal subject.records[index], QuakeliveApi::Items::Record.new(*record)
        end
      end
    end

    describe "emqz" do
      let(:profile) { "emqz" }

      it "fetches proper stats for weapons" do
        [
          ['Gauntlet', 0, nil, nil, nil, 0],
          ['Machinegun', 0, 0, 0, 0, 0],
          ['Shotgun', 0, 0, 0, 0, 0],
          ['Grenade Launcher', 0, 0, 0, 0, 0],
          ['Rocket Launcher', 0, 0, 0, 0, 0],
          ['Lightning Gun', 0, 0, 0, 0, 0],
          ['Railgun', 0, 0, 0, 0, 0],
          ['Plasma Gun', 0, 0, 0, 0, 0],
          ['BFG', 0, 0, 0, 0, 0],
          ['Chaingun', 0, 0, 0, 0, 0],
          ['Nailgun', 0, 0, 0, 0, 0],
          ['Proximity Mine', 0, 0, 0, 0, 0]
        ].each_with_index do |weapon, index|
          assert_equal subject.weapons[index], QuakeliveApi::Items::Weapon.new(*weapon)
        end
      end

      it "fetches proper stats for records" do
        assert_equal subject.records, nil
      end
    end
  end
end
