require "test_helper"

describe "QuakeliveApi::Profile::Statistics" do
  make_my_diffs_pretty!()

  describe "black box test for" do
    let(:subject) do
      VCR.use_cassette("statistics/#{profile}") do
        QuakeliveApi::Profile::Statistics.new(profile)
      end
    end

    describe "xsi" do
      let(:profile) { "xsi" }

      it "fetches proper stats for weapons" do
        [
          ['Gauntlet', 216, nil, nil, nil, 1],
          ['Machinegun', 1232, 29, 64253, 225055, 9],
          ['Shotgun', 2091, 27, 25180, 91693, 9],
          ['Grenade Launcher', 241, 10, 1383, 14163, 3],
          ['Rocket Launcher', 4032, 34, 28182, 83256, 39],
          ['Lightning Gun', 2048, 28, 84326, 304674, 15],
          ['Railgun', 2368, 38, 8339, 21946, 19],
          ['Plasma Gun', 708, 13, 10253, 77655, 5],
          ['Heavy Machinegun', 0, 0, 0, 0, 0],
          ['BFG', 4, 49, 26, 53, 0]
        ].each_with_index do |weapon, index|
          expected_weapon = QuakeliveApi::Items::Weapon.new(*weapon)
          current_weapon = subject.weapons[index]

          assert_equal current_weapon.name, expected_weapon.name
          assert_operator current_weapon.frags.to_i, :>=, expected_weapon.frags.to_i
          assert_operator current_weapon.hits.to_i, :>=, expected_weapon.hits.to_i
          assert_operator current_weapon.shots.to_i, :>=, expected_weapon.shots.to_i
          assert_in_delta expected_weapon.accuracy.to_i, current_weapon.accuracy.to_i, 5
          assert_in_delta expected_weapon.usage.to_i, current_weapon.usage.to_i, 5
        end
      end

      it "fetches proper stats for records" do
        [
          ['Clan Arena', 47, 46, 25, 1, 98, 53],
          ['Capture The Flag', 74, 67, 39, 7, 90, 53],
          ['Free For All', 31, 27, 10, 4, 87, 25],
          ['Domination', 16, 16, 11, 0, 99, 59],
          ['Freeze Tag', 77, 73, 55, 4, 95, 71],
          ['Harvester', 3, 3, 2, 0, 100, 67],
          ['Team Deathmatch', 155, 142, 79, 13, 92, 51],
          ['Duel', 532, 503, 210, 29, 94, 39],
          ['Total', 822, 768, 356, 54, 93, 43]
        ].each_with_index do |record, index|
          expected_record = QuakeliveApi::Items::Record.new(*record)
          current_record = subject.records[index]

          assert_equal current_record.title, expected_record.title
          assert_operator current_record.played, :>=, expected_record.played
          assert_operator current_record.finished, :>=, expected_record.finished
          assert_operator current_record.wins, :>=, expected_record.wins
          assert_operator current_record.quits, :>=, expected_record.quits
          assert_operator current_record.completed, :>=, expected_record.completed
          assert_in_delta expected_record.wins_percentage, current_record.wins_percentage, 5
        end
      end
    end
  end
end
