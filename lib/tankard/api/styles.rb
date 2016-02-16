require_relative './utils/page_finders'

module Tankard
  module Api
    # Access for the /styles route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/style_index
    # @author Matthew Shafer
    class Styles
      include Tankard::Api::Utils::PageFinders
      # @!parse include ::Enumerable

      # @!method each(&block)
      #   Calls the given block once for each style
      #
      #   @yieldparam [Hash] hash containing individual style information
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @return [Tankard::Api::Styles]
      def initialize(request)
        @http_client = request
      end

    private

      attr_reader :http_client

      def http_request_uri
        'styles'.freeze
      end

      def http_request_parameters
        {}
      end
    end
  end
end
