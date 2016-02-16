require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '/spec/'
end

require 'tankard'
require 'rspec'
require 'webmock/rspec'
require 'shared_examples_for_find'

WebMock.disable_net_connect!(allow: 'coveralls.io')

def stub_get(path)
  stub_request(:get, 'http://api.brewerydb.com/v2/' + path)
end

RSpec.configure(&:disable_monkey_patching!)
