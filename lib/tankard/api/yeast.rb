require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /yeast/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/yeast_index
    # @author Matthew Shafer
    class Yeast
      include Tankard::Api::Utils::Find

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Yeast]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = options
        @route = 'yeast'
      end

      # @!method find(id_or_array, options={})
      #   Find a single or multiple yeasts by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a yeast id is passed to find then the hash of the yeast's data is returned.
      #     if an array is passed to find an array containing hashes with each yeast's data is returned.
      #     if a yeast is not found nothing for that yeast is returned.

    private

      attr_reader :http_client
      attr_reader :http_request_parameters
      attr_reader :route
    end
  end
end
