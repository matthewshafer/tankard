# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tankard/version'

Gem::Specification.new do |spec|
  spec.name          = 'tankard'
  spec.version       = Tankard::VERSION
  spec.authors       = ['Matthew Shafer']
  spec.email         = ['matthewshafer@mac.com']
  spec.description   = %q(Connector to the BreweryDB api)
  spec.summary       = %q(Allows easy quering to the breweryDB api)
  spec.homepage      = 'https://github.com/matthewshafer/tankard'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'webmock', '~> 1.20'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rubysl', '~> 2.1' if RUBY_ENGINE == 'rbx'
  spec.add_development_dependency 'json', '~> 1.8' if RUBY_ENGINE == 'rbx'
  spec.add_development_dependency 'rubinius-coverage', '~> 2.0' if RUBY_ENGINE == 'rbx'

  spec.add_dependency 'atomic', '~> 1.1'
  spec.add_dependency 'httpclient', '~> 2.5'
  spec.add_dependency 'multi_json', '~> 1.10'
end
