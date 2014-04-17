require 'hashie'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    # Access for the /beers route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/beer_index
    # @author Matthew Shafer
    class Beers
      include Tankard::Api::Utils::PageFinders
      # @!parse include ::Enumerable

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Beers]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = Hashie::Mash.new(options)
      end

      # @!method each(&block)
      #   Calls the given block once for each beer
      #
      #   @yieldparam [Hash] hash containing individual beer information
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # Beer name to query with
      #
      # @param beer_name [String]
      # @return [self] returns itself
      def name(beer_name)
        @http_request_parameters.name = beer_name
        self
      end

      # Beer abv to query with
      #
      # @param beer_abv [String]
      # @return [self] returns itself
      def abv(beer_abv)
        @http_request_parameters.abv = beer_abv
        self
      end

      def ibu(beer_ibu)
        @http_request_parameters.ibu = beer_ibu
        self
      end

      # Page number to request
      #
      # @param number [Integer]
      # @return [self] returns itself
      def page(number)
        @http_request_parameters.p = number
        self
      end

      # Additional parameters to send with the request
      #
      # @param options [Hash]
      # @return [self] returns itself
      def params(options = {})
        options.each_pair do |key, value|
          @http_request_parameters[key] = value
        end
        self
      end

    private

      attr_reader :http_client
      attr_reader :http_request_parameters

      def http_request_uri
        'beers'
      end
    end
  end
end
