require 'coveralls'
Coveralls.wear!

require "minitest/autorun"
require "webmock/minitest"
require "vcr"
require "quakelive_api"

WebMock.disable_net_connect! allow: %w{coveralls.io}

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures'
  c.hook_into :webmock
end

# taken from its-minitest gem, as I'm used to rspec syntax (and it's quite convenient for blackbox testing)
class MiniTest::Spec
  def self.its attribute, &block
    describe "verify subject.#{attribute} for" do
      let(:inner_subject) { subject.send(attribute) }

      it "verify subject.#{attribute} for" do
        inner_subject.instance_eval(&block)
      end
    end
  end
end
