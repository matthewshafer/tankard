require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /style route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/style_index
    # @author Matthew Shafer
    class Style
      include Tankard::Api::Utils::Find

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Style]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = options
        @route = 'style'
      end

      # @!method find(id_or_array, options={})
      #   Find a single or multiple styles by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a style id is passed to find then the hash of the style is returned.
      #     if an array is passed to find an array containing hashes with each style is returned.
      #     if a style is not found nothing for that style is returned.

    private

      attr_reader :http_client
      attr_reader :http_request_parameters
      attr_reader :route
    end
  end
end
