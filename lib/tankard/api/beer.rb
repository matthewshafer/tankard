require 'hashie'
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
        @request = request
        @options = Hashie::Mash.new(options)
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
        @options.id = beer_id
        self
      end

      # Sets the request to beer/:id/breweries
      #
      # @return [self] returns itself
      def breweries
        @options.endpoint = 'breweries'
        self
      end

      # Sets the request to beer/:id/events
      #
      # @return [self] returns itself
      def events
        @options.endpoint = 'events'
        self
      end

      # Sets the request to beer/:id/ingredients
      #
      # @return [self] returns itself
      def ingredients
        @options.endpoint = 'ingredients'
        self
      end

      # Sets the request to beer/:id/socialaccounts
      #
      # @return [self] returns itself
      def social_accounts
        @options.endpoint = 'socialaccounts'
        self
      end

      # Sets the request to beer/:id/variations
      #
      # @return [self] returns itself
      def variations
        @options.endpoint = 'variations'
        self
      end

      # Additional parameters to send with the request
      #
      # @param options [Hash]
      # @return [self] returns itself
      def params(options = {})
        options.each_pair do |key,value|
          @options[key] = value
        end
        self
      end

      private

        def http_request_uri
          endpoint = "#{route}/#{raise_if_no_id_in_options}"

          if @options.endpoint?
            endpoint += "/#{@options.delete(:endpoint)}"
          end

          endpoint
        end

        def raise_if_no_id_in_options
          raise Tankard::Error::MissingParameter, 'No Beer ID is set' unless @options.id?
          @options.delete(:id)
        end

        def route
          'beer'
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
