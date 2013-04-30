require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '/spec/'
end

require 'tankard'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow: 'coveralls.io')

def stub_get(path)
  stub_request(:get, "http://api.brewerydb.com/v2/" + path)
end