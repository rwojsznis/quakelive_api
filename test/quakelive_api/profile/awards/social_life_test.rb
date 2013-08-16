require "test_helper"

describe "QuakeliveApi::Profile::Awards::SocialLife" do
  make_my_diffs_pretty!

  before do
    profile = "dummy"
    content = fixture_awards('social_life')
    stub_request(:get, "#{QuakeliveApi.site}/profile/awards/#{profile}/5").to_return(content)
    @awards = QuakeliveApi::Profile::Awards::SocialLife.new(profile)
  end

  describe "earned" do
    subject { @awards.earned }

    its(:size){ must_equal 5 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/myquakebook_v2013071600.0.png',
      'We have an opening in marketing for someone like you.',
      'MyQuakeBook',
      Date.parse('09-07-2009'),
      'Invite 25 people who join QUAKE LIVE.') }
  end

  describe "unearned" do
    subject { @awards.unearned }

    its(:size){ must_equal 2 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/qc2009_qc_v2013071600.0.png',
      nil,
      'QuakeCon 2009',
      nil,
      'Presented to any player who completes a game of QUAKE LIVE at QuakeCon.') }
  end
end
