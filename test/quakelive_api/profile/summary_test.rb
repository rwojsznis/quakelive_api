require "test_helper"

describe "QuakeliveApi::Profile::Summary" do
  make_my_diffs_pretty!

  describe "black box test for" do
    before do
      VCR.use_cassette("profiles/#{profile}") do
        @summary = QuakeliveApi::Profile::Summary.new(profile)
      end
    end

    subject { @summary }

    describe "emqz" do
      let(:profile) { "emqz" }

      its(:country) { must_equal "Poland" }
      its(:nick)    { must_equal "emqz"}
      its(:clan)    { must_equal "ORG" }

      its(:model)   { must_equal QuakeliveApi::Items::Model.new(
        "Anarki / Default",
        "http://cdn.quakelive.com/web/2014080602/images/players/body_md/anarki_default_v2014080602.0.png") }

      its(:member_since)       { must_equal Date.parse('23.06.2013') }
      its(:last_game)          { must_be :>, Time.parse('16.12.2013 2:40 PM') }
      its(:time_played)        { must_equal QuakeliveApi::GameTime.new("Ranked Time: 1.11:25:38 Unranked Time: 5.01:12:06") }
      its(:wins)               { must_be :>, 85 }
      its(:losses)             { must_be :>, 135 }
      its(:quits)              { must_be :>, 27 }
      its(:frags)              { must_be :>, 2987 }
      its(:deaths)             { must_be :>, 3660 }
      its(:hits)               { must_be :>, 36_076 }
      its(:shots)              { must_be :>, 185_443 }
      its(:accuracy)           { must_be_within_delta 19, 2 }
      its(:favourite)          { must_equal QuakeliveApi::Items::Favourite.new("Chemical Reaction","Capture The Flag","Rocket Launcher") }
      its(:recent_awards)      { must_include QuakeliveApi::Items::Award.new(
        'http://cdn.quakelive.com/web/2014080602/images/awards/md/sucker_punch_v2014080602.0.png',
        'LOL! Pwn3d!',
        'Sucker Punch',
        'Awarded 9 days ago',
        'Use the Gauntlet to frag an opponent who has Quad Damage.') }

      its(:recent_games) { must_include QuakeliveApi::Items::RecentGame.new(
        'CTF',
        'Win',
        '5 days ago',
        'http://cdn.quakelive.com/web/2014080602/images/levelshots/lg/japanesecastles_v2014080602.0.jpg')
      }

      its(:recent_competitors) { must_include QuakeliveApi::Items::Competitor.new(
        'http://cdn.quakelive.com/web/2014080602/images/players/icon_lg/janet_default_v2014080602.0.png',
        'Good_trade',
        Time.parse('13.08.2014 2:31 PM'))}
    end

    describe "mariano" do
      let(:profile){ "mariano" }

      its(:country) { must_equal "Poland" }
      its(:nick)    { must_equal "Mariano"}
      its(:clan)    { must_equal nil }

      its(:model)   { must_equal QuakeliveApi::Items::Model.new(
        "Sarge / Default",
        "http://cdn.quakelive.com/web/2014080602/images/players/body_md/sarge_default_v2014080602.0.png") }

      its(:member_since)  { must_equal Date.parse('7.02.2009') }
      its(:last_game)     { must_be :>, Time.parse('19.12.2013 7:08 PM') }
      its(:time_played)   { must_equal QuakeliveApi::GameTime.new("Ranked Time: 78.13:26:07 Unranked Time: 14:45:28") }
      its(:wins)          { must_be :>, 5_123 }
      its(:losses)        { must_be :>, 3_709 }
      its(:quits)         { must_be :>, 601 }
      its(:frags)         { must_be :>, 131_866 }
      its(:deaths)        { must_be :>, 121_013 }
      its(:hits)          { must_be :>, 2_671_126 }
      its(:shots)         { must_be :>, 8_355_653 }
      its(:accuracy)      { must_be_within_delta 31, 2 }
      its(:favourite)     { must_equal QuakeliveApi::Items::Favourite.new("Toxicity","Duel","Lightning Gun") }
      its(:recent_awards) { must_include QuakeliveApi::Items::Award.new(
        'http://cdn.quakelive.com/web/2014080602/images/awards/md/winternights2013_v2014080602.0.png',
        '',
        'Winter Nights 2013',
        'Awarded 8 months ago',
        'Complete a match on "Silent Night" or "Winter\'s Edge" during the 2013 holidays.') }

      its(:recent_games) { must_be_instance_of Array }
      its(:recent_games) { wont_include nil }
      its(:recent_games) { must_include QuakeliveApi::Items::RecentGame.new(
        'Duel',
        'Loss',
        '3 days ago',
        'http://cdn.quakelive.com/web/2014080602/images/levelshots/lg/toxicity_v2014080602.0.jpg')
      }

      its(:recent_competitors) { wont_include nil }
      its(:recent_competitors) { must_be_instance_of Array }
    end
  end
end





