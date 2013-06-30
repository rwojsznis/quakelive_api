require "test_helper"


describe "QuakeliveApi::Profile::Summary" do

  describe "black box test for" do
    before  { stub_summary_request(profile, fixture_summary(profile)) }
    subject { QuakeliveApi::Profile::Summary.new(profile) }

    describe "darvin_s_k_2" do
      let(:profile) { "darvin_s_k_2" }

      its(:country)      { must_equal "United States" }
      its(:profile_name)  { must_equal "darvin_S_K_2"}
      its(:clan_name)    { must_equal nil }
      its(:model)        { must_equal "Sarge / Default" }
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

      its(:recent_awards){ must_include ::QuakeliveApi::Award.new('darvin_s_k_2_files/winternights2012_v2013050701.png',
        'Winter Nights 2012',
        'Awarded 6 months ago',
        'Complete a match on "Silent Night" or "Winter\'s Edge" during the 2012 holidays.') }

      its(:recent_awards) { must_include ::QuakeliveApi::Award.new('darvin_s_k_2_files/testing_one_two_v2013050701.png',
        'Testing One..Two..',
        'Awarded 6 months ago',
        'Complete 1 online match.') }

      its(:recent_awards) { wont_include nil }
    end

  end
end
