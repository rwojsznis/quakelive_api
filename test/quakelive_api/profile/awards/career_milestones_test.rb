require "test_helper"

describe "QuakeliveApi::Profile::Awards::CareerMilestones" do
  make_my_diffs_pretty!

  before do
    VCR.use_cassette("awards/career_milestones") do
      @awards = QuakeliveApi::Profile::Awards::CareerMilestones.new('emqz')
    end
  end

  describe "earned" do
    subject { @awards.earned }

    its(:size){ must_equal 6 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2014080602/images/awards/md/guardian_v2014080602.0.png',
      'All you need now is an ear-piece, black suit and shades.',
      'Guardian',
      Date.parse('30-08-2013'),
      'Accumulate 100 Capture the Flag Defend Medals.') }
  end

  describe "unearned" do
    subject { @awards.unearned }

    its(:size){ must_equal 12 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2014080602/images/awards/md/mvp_v2014080602.0.png',
      nil,
      'MVP',
      nil,
      'Accumulate 1000 total Capture the Flag Medals (Caps, Def, and Asst combined).') }
  end
end
