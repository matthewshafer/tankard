require 'hashie'
require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /adjunct/:id route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/adjunct_index
    # @author Matthew Shafer
    class Adjunct
      include Tankard::Api::Utils::Find

      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = Hashie::Mash.new(options)
      end

    private

      attr_reader :http_client
      attr_reader :http_request_parameters

      def route
        'adjunct'
      end
    end
  end
end
