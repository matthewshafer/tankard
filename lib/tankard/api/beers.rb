require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    class Beers
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def name(beer_name)
        @options[:name] = beer_name
        self
      end

      def page(number)
        @options[:p] = number
        self
      end

      def params(options={})
        options.each_pair do |key,value|
          @options[key] = value
        end
        self
      end

      private

        def http_request_uri
          "beers"
        end

        def http_client
          @request
        end

        def http_request_parameters
          @options
        end
    end
  end
end