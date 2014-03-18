require 'tankard/request'
require 'tankard/api/beer'
require 'tankard/api/beers'
require 'tankard/api/search'
require 'tankard/api/styles'
require 'tankard/api/style'

module Tankard
  class Client

    def initialize(options = {})
      Tankard::Configuration::KEYS.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end

      @tankard_request = Tankard::Request.new(@api_key)
    end

    def beer(options = {})
      Tankard::Api::Beer.new(@tankard_request, options)
    end

    def beers(options = {})
      Tankard::Api::Beers.new(@tankard_request, options)
    end

    def search(options = {})
      Tankard::Api::Search.new(@tankard_request, options)
    end

    def styles
      Tankard::Api::Styles.new(@tankard_request)
    end

    def style(options = {})
      Tankard::Api::Style.new(@tankard_request, options)
    end
  end
end
