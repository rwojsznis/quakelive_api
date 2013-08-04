require "test_helper"

describe "QuakeliveApi::Profile::Awards::CareerMilestones" do

  before do
    content = fixture_awards('career')
    stub_request(:get, "#{QuakeliveApi.site}/profile/awards/#{profile}/3").to_return(content)
    @awards = QuakeliveApi::Profile::Awards::CareerMilestones.new(profile)
  end

  subject { @awards }

    describe "xsi" do
      let(:profile) { "xsi" }

      it "fetches earned awards" do
        assert_equal 8, @awards.earned.count
      end

      it "fetches unearned awards" do
        assert_equal 10, @awards.unearned.count
      end
    end
end
