require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'
require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /beer route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/beer_index
    # @author Matthew Shafer
    class Beer
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders
      include Tankard::Api::Utils::Find
      # @!parse include ::Enumerable

      # Initialize a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Beer]
      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      # @!method each(&block)
      #   Calls the given block once for each beer
      #
      #   @yieldparam [Hash] hash containing individual beer information

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
        @options.endpoint = "breweries"
        self
      end

      # Sets the request to beer/:id/events
      #
      # @return [self] returns itself
      def events
        @options.endpoint = "events"
        self
      end

      # Sets the request to beer/:id/ingredients
      #
      # @return [self] returns itself
      def ingredients
        @options.endpoint = "ingredients"
        self
      end

      # Sets the request to beer/:id/socialaccounts
      #
      # @return [self] returns itself
      def social_accounts
        @options.endpoint = "socialaccounts"
        self
      end

      # Sets the request to beer/:id/variations
      #
      # @return [self] returns itself
      def variations
        @options.endpoint = "variations"
        self
      end

      # Additional parameters to send with the request
      #
      # @param options [Hash]
      # @return [self] returns itself
      def params(options={})
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
          raise Tankard::Error::NoBeerId unless @options.id?
          @options.delete(:id)
        end

        def route
          "beer"
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