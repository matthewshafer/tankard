require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    # Access for the /categories route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/category_index
    # @author Matthew Shafer
    class Categories
      include Tankard::Api::Utils::PageFinders
      # @!parse include ::Enumerable

      # @!method each(&block)
      #   Calls the given block once for each category
      #
      #   @yieldparam [Hash] hash containing the information in a category
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @return [Tankard::Api::Categories]
      def initialize(request)
        @http_client = request
      end

    private

      attr_reader :http_client

      def http_request_uri
        'categories'
      end

      def http_request_parameters
        {}
      end
    end
  end
end
