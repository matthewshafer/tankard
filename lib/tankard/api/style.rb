require 'tankard/api/base/find'

module Tankard
  module Api
    # Access for the /style route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/style_index
    # @author Matthew Shafer
    class Style < Tankard::Api::Base::Find
      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Style]

      # @!method find(id_or_array, options={})
      #   Find a single or multiple styles by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a style id is passed to find then the hash of the style is returned.
      #     if an array is passed to find an array containing hashes with each style is returned.
      #     if a style is not found nothing for that style is returned.
      
    private

      def route
        'style'
      end
    end
  end
end
