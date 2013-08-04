require "test_helper"

describe "QuakeliveApi::Profile::Summary" do
  make_my_diffs_pretty!

  describe "black box test for" do
    before  { stub_summary_request(profile, fixture_summary(profile)) }
    subject { QuakeliveApi::Profile::Summary.new(profile) }

    describe "emqz" do
      let(:profile) { "emqz" }

      its(:country) { must_equal "Poland" }
      its(:nick)    { must_equal "emqz"}
      its(:clan)    { must_equal nil }

      its(:model)   { must_equal QuakeliveApi::Items::Model.new(
        "Major / Default",
        "http://cdn.quakelive.com/web/2013071600/images/players/body_md/major_default_v2013071600.0.png") }

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
      its(:favourite)          { must_equal QuakeliveApi::Items::Favourite.new(nil, nil, nil) }
      its(:recent_awards)      { must_equal nil }
      its(:recent_games)       { must_equal nil }
      its(:recent_competitors) { must_equal nil }
    end

    describe "mariano" do
      let(:profile){ "mariano" }

      its(:country) { must_equal "Poland" }
      its(:nick)    { must_equal "Mariano"}
      its(:clan)    { must_equal nil }

      its(:model)   { must_equal QuakeliveApi::Items::Model.new(
        "Bitterman / Default",
        "http://cdn.quakelive.com/web/2013071600/images/players/body_md/bitterman_default_v2013071600.0.png") }

      its(:member_since)  { must_equal Date.parse('7.02.2009') }
      its(:last_game)     { must_equal Time.parse('11-07-2013 2:59 PM') }
      its(:time_played)   { must_equal QuakeliveApi::GameTime.new("Ranked Time: 52.19:25:52 Unranked Time: 02:31:02") }
      its(:wins)          { must_equal 4278 }
      its(:losses)        { must_equal 3015 }
      its(:quits)         { must_equal 518 }
      its(:frags)         { must_equal 97_102 }
      its(:deaths)        { must_equal 88_381 }
      its(:hits)          { must_equal 1_960_767 }
      its(:shots)         { must_equal 6_085_608 }
      its(:accuracy)      { must_equal 32.22 }
      its(:favourite)     { must_equal QuakeliveApi::Items::Favourite.new("Furious Heights","Duel","Lightning Gun") }
      its(:recent_awards) { must_include QuakeliveApi::Items::Award.new(
        'http://cdn.quakelive.com/web/2013071600/images/awards/md/team_killer_v2013071600.0.png',
        'Hope you touched the flag first!',
        'Team Killer',
        'Awarded 2 months ago',
        'Kill all players on the opposing team in a single round in Attack & Defend, minimum size 3.') }

      its(:recent_awards)      { must_include QuakeliveApi::Items::Award.new(
        'http://cdn.quakelive.com/web/2013071600/images/awards/md/pql_1_v2013071600.0.png',
        'Do you think thats air youre breathing now?',
        'Too Fast',
        'Awarded 2 months ago',
        'Complete 1 online PQL match.') }

      its(:recent_games) { must_be_instance_of Array }
      its(:recent_games) { wont_include nil }
      its(:recent_games) { must_include QuakeliveApi::Items::RecentGame.new(
        'TDM',
        'Loss',
        '20 days ago',
        'http://cdn.quakelive.com/web/2013071600/images/levelshots/lg/hiddenfortress_v2013071600.0.jpg')
      }

      its(:recent_competitors) { wont_include nil }
      its(:recent_competitors) { must_be_instance_of Array }
      its(:recent_competitors) { must_include QuakeliveApi::Items::Competitor.new(
        'http://cdn.quakelive.com/web/2013071600/images/players/icon_lg/bitterman_red_v2013071600.0.png',
        'Jeezy',
        Time.parse('2013-07-11 14:59:00'))}
    end
  end
end





