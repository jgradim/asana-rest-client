# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asana/version'

Gem::Specification.new do |spec|
  spec.name          = "asana-rest-client"
  spec.version       = Asana::VERSION
  spec.authors       = ["João Gradim"]
  spec.email         = ["joao.gradim@gmail.com"]
  spec.summary       = %q{Ruby client for Asana REST API}
  spec.description   = %q{Ruby client for Asana REST API supporting API and OAuth tokens}
  spec.homepage      = "https://github.com/jgradim/asana-rest-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",            "~> 0.8"
  spec.add_dependency "faraday_middleware", "~> 0.9"

  spec.add_development_dependency "bundler" , "~> 1.5"
  spec.add_development_dependency "rake"    , "~> 10.3"
  spec.add_development_dependency "rspec"   , "~> 2.14"
  spec.add_development_dependency "webmock" , "~> 1.15"
  spec.add_development_dependency "vcr"     , "~> 2.9"
end
