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
          ['Machinegun', 1232, 29, 64253, 225055, 9],
          ['Shotgun', 2091, 27, 25180, 91693, 9],
          ['Grenade Launcher', 241, 10, 1383, 14163, 3],
          ['Rocket Launcher', 4032, 34, 28182, 83256, 39],
          ['Lightning Gun', 2048, 28, 84326, 304674, 15],
          ['Railgun', 2368, 38, 8339, 21946, 19],
          ['Plasma Gun', 708, 13, 10253, 77655, 5],
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
          ['Team Deathmatch', 155, 142, 79, 13, 92, 51],
          ['Duel', 532, 503, 210, 29, 95, 39],
          ['Total', 822, 768, 356, 54, 93, 43]
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
