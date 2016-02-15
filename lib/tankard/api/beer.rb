require 'tankard/api/utils/page_finders'
require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /beer route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/beer_index
    # @author Matthew Shafer
    class Beer
      include Tankard::Api::Utils::PageFinders
      include Tankard::Api::Utils::Find
      # @!parse include ::Enumerable

      # Initialize a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Beer]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = options
      end

      # @!method find(id_or_array, options={})
      #   Find a single or multiple beers by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a beer id is passed to find then the hash of the beer is returned.
      #     if an array is passed to find an array containing hashes with each beer is returned.
      #     if a beer is not found nothing for that beer is returned.

      # @!method each(&block)
      #   Calls the given block once for each beer
      #
      #   @yieldparam [Hash] hash containing individual beer information
      #   @raise [Tankard::Error::MissingParameter] when the id is not set
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # BeerID to query
      #
      # @param beer_id [String]
      # @return [self] returns itself
      def id(beer_id)
        @http_request_parameters[:id] = beer_id
        self
      end

      # Sets the request to beer/:id/adjuncts
      #
      # @return [self] returns itself
      def adjuncts
        @http_request_parameters[:endpoint] = 'adjuncts'
        self
      end

      # Sets the request to beer/:id/breweries
      #
      # @return [self] returns itself
      def breweries
        @http_request_parameters[:endpoint] = 'breweries'
        self
      end

      # Sets the request to beer/:id/events
      #
      # @return [self] returns itself
      def events
        @http_request_parameters[:endpoint] = 'events'
        self
      end

      # Sets the request to beer/:id/fermentables
      #
      # @return [self] returns itself
      def fermentables
        @http_request_parameters[:endpoint] = 'fermentables'
        self
      end

      # Sets the request to beer/:id/hops
      #
      # @return [self] returns itself
      def hops
        @http_request_parameters[:endpoint] = 'hops'
        self
      end

      # Sets the request to beer/:id/ingredients
      #
      # @return [self] returns itself
      def ingredients
        @http_request_parameters[:endpoint] = 'ingredients'
        self
      end

      # Sets the request to beer/:id/socialaccounts
      #
      # @return [self] returns itself
      def social_accounts
        @http_request_parameters[:endpoint] = 'socialaccounts'
        self
      end

      # Sets the reques to beer/:id/upcs
      #
      # @return [self] returns itself
      def upcs
        @http_request_parameters[:endpoint] = 'upcs'
        self
      end

      # Sets the request to beer/:id/variations
      #
      # @return [self] returns itself
      def variations
        @http_request_parameters[:endpoint] = 'variations'
        self
      end

      # Sets the reques to beer/:id/yeasts
      #
      # @return [self] returns itself
      def yeasts
        @http_request_parameters[:endpoint] = 'yeasts'
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

      attr_reader :http_client, :http_request_parameters

      def http_request_uri
        @request_endpoint = "/#{@http_request_parameters.delete(:endpoint)}" if @http_request_parameters[:endpoint]
        endpoint = "#{route}/#{raise_if_no_id_in_options}"
        endpoint += @request_endpoint if @request_endpoint
        endpoint
      end

      def raise_if_no_id_in_options
        @beer_id = @http_request_parameters.delete(:id) if @http_request_parameters[:id]
        fail Tankard::Error::MissingParameter, 'No Beer ID is set' unless @beer_id
        @beer_id
      end

      def route
        'beer'
      end
    end
  end
end
