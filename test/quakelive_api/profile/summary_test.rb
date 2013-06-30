require "test_helper"


describe "QuakeliveApi::Profile::Summary" do
  make_my_diffs_pretty!()

  describe "black box test for" do
    before  { stub_summary_request(profile, fixture_summary(profile)) }
    subject { QuakeliveApi::Profile::Summary.new(profile) }

    describe "darvin_s_k_2" do
      let(:profile) { "darvin_s_k_2" }

      its(:country)      { must_equal "United States" }
      its(:profile_name) { must_equal "darvin_S_K_2"}
      its(:clan_name)    { must_equal nil }

      its(:model)        { must_equal ::QuakeliveApi::Model.new(
        "Sarge / Default",
        "http://cdn.quakelive.com/web/2013050701/images/players/body_md/sarge_default_v2013050701.0.png") }

      its(:member_since) { must_equal Date.parse('18.12.2012') }
      its(:last_game)    { must_equal Time.parse('19.12.2012 12:43 AM')}
      its(:time_played)  { must_equal ::QuakeliveApi::GameTime.new("Ranked Time: 21:50 Unranked Time: 04:54") }
      its(:wins)         { must_equal 0 }
      its(:losses)       { must_equal 6 }
      its(:quits)        { must_equal 5 }
      its(:frags)        { must_equal 1 }
      its(:deaths)       { must_equal 31 }
      its(:hits)         { must_equal 5 }
      its(:shots)        { must_equal 77 }
      its(:accuracy)     { must_equal 6.49 }
      its(:favourite)    { must_equal ::QuakeliveApi::Favourite.new("Deep Inside","Clan Arena","Rocket Launcher") }

      its(:recent_awards){ must_be_instance_of Array }
      its(:recent_awards) { wont_include nil }
      its(:recent_awards){ must_include ::QuakeliveApi::Award.new(
        'darvin_s_k_2_files/winternights2012_v2013050701.png',
        'Stuff some stockings with a grenade or two.',
        'Winter Nights 2012',
        'Awarded 6 months ago',
        'Complete a match on "Silent Night" or "Winter\'s Edge" during the 2012 holidays.') }
      its(:recent_awards) { must_include ::QuakeliveApi::Award.new(
        'darvin_s_k_2_files/testing_one_two_v2013050701.png',
        'We told you this was easy.',
        'Testing One..Two..',
        'Awarded 6 months ago',
        'Complete 1 online match.') }

      its(:recent_games){ must_be_instance_of Array }
      its(:recent_games)  { wont_include nil }
      its(:recent_games)  { must_include ::QuakeliveApi::RecentGame.new(
        'CA',
        'Quit',
        '6 months ago',
        'darvin_s_k_2_files/hiddenfortress_v2013050701.jpg')
      }

      its(:recent_competitors) { wont_include nil }
      its(:recent_competitors) { must_be_instance_of Array }
      its(:recent_competitors) { must_include ::QuakeliveApi::Competitor.new(
        'http://cdn.quakelive.com/web/2013050701/images/players/icon_lg/razor_red_v2013050701.0.png',
        'devinseven',
        Time.parse('18-12-2012 1:29 AM'))}
      its(:recent_competitors) { must_include ::QuakeliveApi::Competitor.new(
        'http://cdn.quakelive.com/web/2013050701/images/players/icon_lg/visor_default_v2013050701.0.png',
        'oso|TheScaredOne', # maybe we should also handle clan tags here?
        Time.parse('19-12-2012 12:43 AM'))}
    end

    describe "emqz" do
      let(:profile) { "emqz" }

      its(:country)            { must_equal "Poland" }
      its(:profile_name)       { must_equal "emqz"}
      its(:clan_name)          { must_equal nil }

      its(:model)              { must_equal ::QuakeliveApi::Model.new(
        "Major / Default",
        "http://cdn.quakelive.com/web/2013050701/images/players/body_md/major_default_v2013050701.0.png") }

      its(:member_since)       { must_equal Date.parse('23.06.2013') }
      its(:last_game)          { must_equal nil }
      its(:time_played)        { must_equal nil }
      its(:wins)               { must_equal 0 }
      its(:losses)             { must_equal 0 }
      its(:quits)              { must_equal 0 }
      its(:frags)              { must_equal 0 }
      its(:deaths)             { must_equal 0 }
      its(:hits)               { must_equal 0 }
      its(:shots)              { must_equal 0 }
      its(:accuracy)           { must_equal 0.0 }
      its(:favourite)          { must_equal ::QuakeliveApi::Favourite.new(nil, nil, nil) }
      its(:recent_awards)      { must_equal nil }
      its(:recent_games)       { must_equal nil }
      its(:recent_competitors) { must_equal nil }
    end

    describe "mariano" do
      let(:profile){ "mariano" }

      its(:country)            { must_equal "Poland" }
      its(:profile_name)       { must_equal "Mariano"}
      its(:clan_name)          { must_equal nil }

      its(:model)              { must_equal ::QuakeliveApi::Model.new(
        "Bitterman / Sport_blue",
        "http://cdn.quakelive.com/web/2013050701/images/players/body_md/bitterman_sport_blue_v2013050701.0.png") }

      its(:member_since)       { must_equal Date.parse('7.02.2009') }
      its(:last_game)          { must_equal Time.parse('22-06-2013 7:36 PM') }
      its(:time_played)        { must_equal ::QuakeliveApi::GameTime.new("Ranked Time: 50.06:18:30 Unranked Time: 02:31:02") }
      its(:wins)               { must_equal 4160 }
      its(:losses)             { must_equal 2905 }
      its(:quits)              { must_equal 511 }
      its(:frags)              { must_equal 90_736 }
      its(:deaths)             { must_equal 82_117 }
      its(:hits)               { must_equal 1_828_132 }
      its(:shots)              { must_equal 5_651_134 }
      its(:accuracy)           { must_equal 32.35 }
      its(:favourite)          { must_equal ::QuakeliveApi::Favourite.new("Furious Heights","Duel","Lightning Gun") }
      its(:recent_awards)      { must_include ::QuakeliveApi::Award.new(
        'mariano_files/team_killer_v2013050701.png',
        'Hope you touched the flag first!',
        'Team Killer',
        'Awarded 18 days ago',
        'Kill all players on the opposing team in a single round in Attack & Defend, minimum size 3.') }

      its(:recent_awards)      { must_include ::QuakeliveApi::Award.new(
        'mariano_files/pql_1_v2013050701.png',
        'Do you think thats air youre breathing now?',
        'Too Fast',
        'Awarded 28 days ago',
        'Complete 1 online PQL match.') }

      its(:recent_games)  { must_include ::QuakeliveApi::RecentGame.new(
        'TDM',
        'Win',
        '16 hours ago',
        'mariano_files/dreadfulplace_v2013050701.jpg')
      }

      its(:recent_competitors) { must_include ::QuakeliveApi::Competitor.new(
        'http://cdn.quakelive.com/web/2013050701/images/players/icon_lg/crash_sport_v2013050701.0.png',
        '+_+Danunah',
        Time.parse('22-06-2013 6:21 PM'))}
    end
  end
end





