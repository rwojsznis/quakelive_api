require "test_helper"

describe "QuakeliveApi::Profile::Awards::SweetSuccess" do
  make_my_diffs_pretty!

  before do
    profile = "dummy"
    content = fixture_awards('sweet_success')
    stub_request(:get, "#{QuakeliveApi.site}/profile/awards/#{profile}/4").to_return(content)
    @awards = QuakeliveApi::Profile::Awards::SweetSuccess.new(profile)
  end

  describe "earned" do
    subject { @awards.earned }

    its(:size){ must_equal 16 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/pack_hunter_v2013071600.0.png',
      'Skill, control, strategy - you\'ve got it all.',
      'Pack Hunter',
      Date.parse('04-03-2013'),
      'Win 75 Team Deathmatch matches.') }
  end

  describe "unearned" do
    subject { @awards.unearned }

    its(:size){ must_equal 16 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/shut_out_v2013071600.0.png',
      nil,
      'Shut Out',
      nil,
      'Win a Clan Arena match (of at least 5 rounds) without losing a round.') }
  end
end
