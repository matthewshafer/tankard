require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /category/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/category_index
    # @author Matthew Shafer
    class Category
      include Tankard::Api::Utils::Find

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Category]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = options
        @route = 'category'
      end

      # @!method find(id_or_array, options={})
      #   Find a single or multiple categories by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a category id is passed to find and an object is found then a hash is returned.
      #     if an array is passed to find an array containing hashes with each category is returned.
      #     if the category is not found then nil is returned.

    private

      attr_reader :http_client, :http_request_parameters, :route
    end
  end
end
