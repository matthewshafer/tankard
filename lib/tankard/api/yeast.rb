require 'tankard/api/base/find'

module Tankard
  module Api
    # Access for the /yeast/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/yeast_index
    # @author Matthew Shafer
    class Yeast < Tankard::Api::Base::Find
      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Yeast]

      # @!method find(id_or_array, options={})
      #   Find a single or multiple yeasts by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a yeast id is passed to find then the hash of the yeast's data is returned.
      #     if an array is passed to find an array containing hashes with each yeast's data is returned.
      #     if a yeast is not found nothing for that yeast is returned.

    private

      def route
        'yeast'
      end
    end
  end
end
