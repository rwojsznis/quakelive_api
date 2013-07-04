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

    end
  end
end
