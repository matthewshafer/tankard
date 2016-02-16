require 'tankard/api/base/find'

module Tankard
  module Api
    # Access for the /category/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/category_index
    # @author Matthew Shafer
    class Category < Tankard::Api::Base::Find
      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Category]

      # @!method find(id_or_array, options={})
      #   Find a single or multiple categories by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a category id is passed to find and an object is found then a hash is returned.
      #     if an array is passed to find an array containing hashes with each category is returned.
      #     if the category is not found then nil is returned.

    private

      def route
        'category'.freeze
      end
    end
  end
end
