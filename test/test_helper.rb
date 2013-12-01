require 'coveralls'
Coveralls.wear!

require "minitest/autorun"
require "webmock/minitest"
WebMock.disable_net_connect! allow: %w{coveralls.io}

require "#{File.dirname(__FILE__)}/../lib/quakelive_api"

def fixtures_path
  "#{File.dirname(__FILE__)}/fixtures"
end

def fixture_profile(name)
  File.read "#{fixtures_path}/profile/#{name}.txt"
end

def fixture_summary(name)
  File.read "#{fixtures_path}/summary/#{name}.txt"
end

def fixture_statistics(name)
  File.read "#{fixtures_path}/statistics/#{name}.txt"
end

def fixture_awards(name)
  File.read "#{fixtures_path}/awards/#{name}.txt"
end

def stub_summary_request(profile_name, content)
  stub_request(:get, "#{QuakeliveApi.site}/profile/summary/#{profile_name}").to_return(content)
end

def stub_stats_request(profile_name, content)
  stub_request(:get, "#{QuakeliveApi.site}/profile/statistics/#{profile_name}").to_return(content)
end

# taken from its-minitest gem, as I'm used to rspec syntax (and it's quite convenient for blackbox testing)
class MiniTest::Spec
  def self.its attribute, &block
    describe "verify subject.#{attribute} for" do
      let(:inner_subject) { subject.send(attribute) }

      it "verify subject.#{attribute} for" do
        inner_subject.instance_eval &block
      end
    end
  end
end
