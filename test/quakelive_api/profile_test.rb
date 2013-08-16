require "test_helper"

describe "QuakeliveApi::Profile" do

  describe "on error" do
    it "raises an exception on non existing profiles" do
      stub_summary_request "not-here", fixture_profile("not_found")
      profile = QuakeliveApi::Profile.new('not-here')
      assert_raises(QuakeliveApi::Error::PlayerNotFound) { profile.summary }
    end

    it "raises an exception on request error response from ql" do
      stub_summary_request "error-profile", fixture_profile("error")
      profile = QuakeliveApi::Profile.new('error-profile')
      assert_raises(QuakeliveApi::Error::RequestError) { profile.summary }
    end
  end

  describe "on success" do
    it "returns an instance of summary class on 'summary' call" do
      stub_summary_request "all-good", fixture_summary("emqz")
      profile = QuakeliveApi::Profile.new('all-good')
      assert_instance_of QuakeliveApi::Profile::Summary, profile.summary
    end

    it "returns an instance of statistics class on 'statistics' call" do
      stub_stats_request "stats-test", fixture_statistics("xsi")
      profile = QuakeliveApi::Profile.new('stats-test')
      assert_instance_of QuakeliveApi::Profile::Statistics, profile.statistics
    end

    it "returns an instance of career milestones class on 'awards_milestones' call" do
      profile = QuakeliveApi::Profile.new('awards-test')
      stub_request(:get, "http://www.quakelive.com/profile/awards/awards-test/3")
      assert_instance_of QuakeliveApi::Profile::Awards::CareerMilestones, profile.awards_milestones
    end

    it "returns an instance of experience class on 'awards_experience' call" do
      profile = QuakeliveApi::Profile.new('awards-test')
      stub_request(:get, "http://www.quakelive.com/profile/awards/awards-test/1")
      assert_instance_of QuakeliveApi::Profile::Awards::Experience, profile.awards_experience
    end

    it "returns an instance of mad skillz class on 'awards_skillz' call" do
      profile = QuakeliveApi::Profile.new('awards-test')
      stub_request(:get, "http://www.quakelive.com/profile/awards/awards-test/2")
      assert_instance_of QuakeliveApi::Profile::Awards::MadSkillz, profile.awards_skillz
    end

    it "returns an instance of social life class on 'awards_social' call" do
      profile = QuakeliveApi::Profile.new('awards-test')
      stub_request(:get, "http://www.quakelive.com/profile/awards/awards-test/5")
      assert_instance_of QuakeliveApi::Profile::Awards::SocialLife, profile.awards_social
    end

    it "returns an instance of sweet success class on 'awards_success' call" do
      profile = QuakeliveApi::Profile.new('awards-test')
      stub_request(:get, "http://www.quakelive.com/profile/awards/awards-test/4")
      assert_instance_of QuakeliveApi::Profile::Awards::SweetSuccess, profile.awards_success
    end

    it "responds to each_award" do
      profile = QuakeliveApi::Profile.new('awards-test')
      assert_respond_to(profile, :each_award)
    end
  end
end
