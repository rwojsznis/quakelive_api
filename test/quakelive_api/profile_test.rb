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
  end

end
