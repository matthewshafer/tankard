require 'tankard/request'
require 'tankard/api/beer'
require 'tankard/api/beers'
require 'tankard/api/styles'

module Tankard
  class Client

    def initialize(options={})
      Tankard::Configuration::KEYS.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end

      @tankard_request = Tankard::Request.new(@api_key)
    end

    def beer(options={})
      Tankard::Api::Beer.new(@tankard_request, options)
    end

    def beers(options={})
      Tankard::Api::Beers.new(@tankard_request, options)
    end

    def styles
      Tankard::Api::Styles.new(@tankard_request)
    end
  end
end