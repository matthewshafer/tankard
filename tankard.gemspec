# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tankard/version'

Gem::Specification.new do |spec|
  spec.name          = "tankard"
  spec.version       = Tankard::VERSION
  spec.authors       = ["Matthew Shafer"]
  spec.email         = ["matthewshafer@mac.com"]
  spec.description   = %q{Connector to the BreweryDB api}
  spec.summary       = %q{Allows easy quering to the breweryDB api}
  spec.homepage      = "https://github.com/matthewshafer/tankard"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "webmock", "~> 1.16"
  spec.add_development_dependency "simplecov", "~> 0.8"
  spec.add_development_dependency "coveralls", "~> 0.7"
  spec.add_development_dependency "pry", "~> 0.9.12"
  spec.add_development_dependency "rubysl", "~> 2.0" if RUBY_ENGINE == 'rbx'
  spec.add_development_dependency "rubinius-coverage", "~> 2.0" if RUBY_ENGINE == 'rbx'

  spec.add_dependency "atomic", "~> 1.1"
  spec.add_dependency "httpclient", "~> 2.3"
  spec.add_dependency "multi_json", "~> 1.8"
  spec.add_dependency "hashie", "~> 2.0"
end
