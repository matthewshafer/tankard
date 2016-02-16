require_relative './base/page_finders'

module Tankard
  module Api
    # Access for the /adjuncts route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/adjunct_index
    # @author Matthew Shafer
    class Adjuncts < Tankard::Api::Base::PageFinders
      # @!parse include ::Enumerable

      # @!method initialize(request, options = {})
      #   Initialize a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Adjuncts]

      # @!method each(&block)
      #   Calls the given block once for each adjunct
      #
      #   @yieldparam [Hash] hash containing individual adjunct information
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # @!method page(number)
      #   page number to query
      #
      #   @param beer_id [String]
      #   @return [self] returns itself

      # @!method params(options = {})
      #   Additional parameters to send with the request
      #
      #   @param options [Hash]
      #   @return [self] returns itself

    private

      def http_request_uri
        'adjuncts'.freeze
      end
    end
  end
end
