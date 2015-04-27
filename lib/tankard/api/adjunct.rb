require 'hashie'
require 'tankard/api/base/find'

module Tankard
  module Api
    # Access for the /adjunct/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/adjunct_index
    # @author Matthew Shafer
    class Adjunct < Tankard::Api::Base::Find
      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Adjunct]

      # @!method find(id_or_array, options={})
      #   Find a single or multiple adjunct's by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a adjunct id is passed to find then the hash of the adjunct's data is returned.
      #     if an array is passed to find an array containing hashes with each adjunct's data is returned.
      #     if an adjunct is not found nothing for that adjunct is returned.

    private

      def route
        'adjunct'
      end
    end
  end
end
