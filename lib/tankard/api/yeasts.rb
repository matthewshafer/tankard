require 'hashie'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    # Access for the /yeasts route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/yeast_index
    # @author Matthew Shafer
    class Yeasts
      include Tankard::Api::Utils::PageFinders
      # @!parse include ::Enumerable

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Yeasts]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = Hashie::Mash.new(options)
        @http_request_uri = 'yeasts'
      end

      # @!method each(&block)
      #   Calls the given block once for each yeast
      #
      #   @yieldparam [Hash] hash containing individual yeast's information
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # Specific page to request
      #
      # @param number [Integer]
      # @return [self] returns itself
      def page(number)
        @http_request_parameters[:p] = number
        self
      end

    private

      attr_reader :http_client
      attr_reader :http_request_parameters
      attr_reader :http_request_uri

    end
  end
end
