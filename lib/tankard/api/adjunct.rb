require 'hashie'
require 'tankard/api/base/find'

module Tankard
  module Api
    # Access for the /adjunct/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/adjunct_index
    # @author Matthew Shafer
    class Adjunct < Tankard::Api::Base::Find
    private

      def route
        'adjunct'
      end
    end
  end
end
