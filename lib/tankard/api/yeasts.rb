require 'tankard/api/base/page_finders'

module Tankard
  module Api
    # Access for the /yeasts route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/yeast_index
    # @author Matthew Shafer
    class Yeasts < Tankard::Api::Base::PageFinders
      # @!parse include ::Enumerable

      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Yeasts]

      # @!method each(&block)
      #   Calls the given block once for each yeast
      #
      #   @yieldparam [Hash] hash containing individual yeast's information
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # @!method page(number)
      #   Specific page to request
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
        'yeasts'.freeze
      end

    end
  end
end
