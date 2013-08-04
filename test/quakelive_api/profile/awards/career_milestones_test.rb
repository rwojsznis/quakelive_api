require "test_helper"

describe "QuakeliveApi::Profile::Awards::CareerMilestones" do
  make_my_diffs_pretty!

  before do
    content = fixture_awards('career')
    stub_request(:get, "#{QuakeliveApi.site}/profile/awards/#{profile}/3").to_return(content)
    @awards = QuakeliveApi::Profile::Awards::CareerMilestones.new(profile)
  end

  describe "xsi" do
    let(:profile) { "xsi" }

    describe "earned" do
      subject { @awards.earned }

      its(:size){ must_equal 8 }
      it { subject.must_be_instance_of Array }
      it { subject.must_include QuakeliveApi::Items::Award.new(
        'http://cdn.quakelive.com/web/2013071600/images/awards/md/guardian_v2013071600.0.png',
        'All you need now is an ear-piece, black suit and shades.',
        'Guardian',
        Date.parse('09-07-2009'),
        'Accumulate 100 Capture the Flag Defend Medals.') }
    end

    describe "unearned" do
      subject { @awards.unearned }

      its(:size){ must_equal 10 }
      it { subject.must_be_instance_of Array }
      it { subject.must_include QuakeliveApi::Items::Award.new(
        'http://cdn.quakelive.com/web/2013071600/images/awards/md/mvp_v2013071600.0.png',
        nil,
        'MVP',
        nil,
        'Accumulate 1000 total Capture the Flag Medals (Caps, Def, and Asst combined).') }
    end
  end
end
