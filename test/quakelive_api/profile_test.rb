# coding: utf-8
require "test_helper"

describe "QuakeliveApi::Profile" do

  describe "on error" do
    it "raises an exception on non existing profiles" do
      VCR.use_cassette("profiles/not_existing") do
        profile = QuakeliveApi::Profile.new('not_existing_profile123')
        assert_raises(QuakeliveApi::Error::PlayerNotFound) { profile.summary }
      end
    end

    it "raises an exception on request error response from ql" do
      VCR.use_cassette("profiles/error") do
        profile = QuakeliveApi::Profile.new('óąśðł')
        assert_raises(QuakeliveApi::Error::RequestError) { profile.summary }
      end
    end
  end

  describe "on success" do
    it "returns an instance of summary class on 'summary' call" do
      VCR.use_cassette("profiles/full/summary") do
        profile = QuakeliveApi::Profile.new('emqz')
        assert_instance_of QuakeliveApi::Profile::Summary, profile.summary
      end
    end

    it "returns an instance of statistics class on 'statistics' call" do
      VCR.use_cassette("profiles/full/statistics") do
        profile = QuakeliveApi::Profile.new('xsi')
        assert_instance_of QuakeliveApi::Profile::Statistics, profile.statistics
      end
    end

    it "returns an instance of career milestones class on 'awards_milestones' call" do
      VCR.use_cassette("profiles/full/awards_milestones") do
        profile = QuakeliveApi::Profile.new('emqz')
        assert_instance_of QuakeliveApi::Profile::Awards::CareerMilestones, profile.awards_milestones
      end
    end

    it "returns an instance of experience class on 'awards_experience' call" do
      VCR.use_cassette("profiles/full/awards_experience") do
        profile = QuakeliveApi::Profile.new('emqz')
        assert_instance_of QuakeliveApi::Profile::Awards::Experience, profile.awards_experience
      end
    end

    it "returns an instance of mad skillz class on 'awards_skillz' call" do
      VCR.use_cassette("profiles/full/awards_skillz") do
        profile = QuakeliveApi::Profile.new('awards-test')
        assert_instance_of QuakeliveApi::Profile::Awards::MadSkillz, profile.awards_skillz
      end
    end

    it "returns an instance of social life class on 'awards_social' call" do
      VCR.use_cassette("profiles/full/awards_social") do
        profile = QuakeliveApi::Profile.new('xsi')
        assert_instance_of QuakeliveApi::Profile::Awards::SocialLife, profile.awards_social
      end
    end

    it "returns an instance of sweet success class on 'awards_success' call" do
      VCR.use_cassette("profiles/full/awards_success") do
        profile = QuakeliveApi::Profile.new('emqz')
        assert_instance_of QuakeliveApi::Profile::Awards::SweetSuccess, profile.awards_success
      end
    end
  end
end
