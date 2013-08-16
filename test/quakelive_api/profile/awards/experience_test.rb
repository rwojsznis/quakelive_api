require "test_helper"

describe "QuakeliveApi::Profile::Awards::Experience" do
  make_my_diffs_pretty!

  before do
    profile = "dummy"
    content = fixture_awards('experience')
    stub_request(:get, "#{QuakeliveApi.site}/profile/awards/#{profile}/1").to_return(content)
    @awards = QuakeliveApi::Profile::Awards::Experience.new(profile)
  end

  describe "earned" do
    subject { @awards.earned }

    its(:size){ must_equal 11 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/space_cadet_v2013071600.0.png',
      'Unfortunately, we don\'t offer frequent flyer miles.',
      'Space Cadet',
      Date.parse('18-12-2012'),
      'Complete 1 online match (of at least 5 min.) in each space arena.') }
  end

  describe "unearned" do
    subject { @awards.unearned }

    its(:size){ must_equal 25 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/champion_v2013071600.0.png',
      nil,
      'Champion',
      nil,
      'Complete 10,000 online matches.') }
  end
end
