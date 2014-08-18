# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quakelive_api/version'

Gem::Specification.new do |spec|
  spec.name          = "quakelive_api"
  spec.version       = QuakeliveApi::VERSION
  spec.authors       = ["Rafal Wojsznis"]
  spec.email         = ["rafal.wojsznis@gmail.com"]
  spec.description   = %q{Pseudo API for QuakeLive}
  spec.summary       = %q{Fetch some basic information from QuakeLive site}
  spec.homepage      = "https://github.com/emq/quakelive_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '>= 1.5'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.2.0'
  spec.add_development_dependency 'webmock', '~> 1.18.0'
  spec.add_development_dependency 'vcr', '~> 2.9.2'
  spec.add_development_dependency 'coveralls', '~> 0.7.1'
end
