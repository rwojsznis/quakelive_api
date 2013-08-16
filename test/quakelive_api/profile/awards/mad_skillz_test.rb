require "test_helper"

describe "QuakeliveApi::Profile::Awards::MadSkillz" do
  make_my_diffs_pretty!

  before do
    profile = "dummy"
    content = fixture_awards('mad_skillz')
    stub_request(:get, "#{QuakeliveApi.site}/profile/awards/#{profile}/2").to_return(content)
    @awards = QuakeliveApi::Profile::Awards::MadSkillz.new(profile)
  end

  describe "earned" do
    subject { @awards.earned }

    its(:size){ must_equal 21 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/psychic_v2013071600.0.png',
      'You\'re either lucky or good.',
      'Psychic',
      Date.parse('16-07-2009'),
      'Use a rocket to kill an opponent who is in the air.') }
  end

  describe "unearned" do
    subject { @awards.unearned }

    its(:size){ must_equal 22 }
    it { subject.must_be_instance_of Array }
    it { subject.must_include QuakeliveApi::Items::Award.new(
      'http://cdn.quakelive.com/web/2013071600/images/awards/md/forcing_the_city_gates_v2013071600.0.png',
      nil,
      'Forcing the City Gates',
      nil,
      'Score at least 5 frags in a round in Red Rover.') }
  end
end
