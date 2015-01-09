require 'hashie'
require 'tankard/api/base/page_finders'

module Tankard
  module Api
    # Access for the /beers route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/beer_index
    # @author Matthew Shafer
    class Beers < Tankard::Api::Base::PageFinders
      # @!parse include ::Enumerable

      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Beers]

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

      # Beer ibu to query with
      #
      # @param beer_ibu [String]
      # @return [self] returns itself
      def ibu(beer_ibu)
        @http_request_parameters.ibu = beer_ibu
        self
      end

      # @!method page(number)
      #   Page number to request
      #
      #   @param number [Integer]
      #   @return [self] returns itself

      # @!method params(options = {})
      #   Additional parameters to send with the request
      #
      #   @param options [Hash]
      #   @return [self] returns itself

    private

      def http_request_uri
        'beers'
      end
    end
  end
end
