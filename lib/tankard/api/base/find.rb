require 'tankard/api/utils/find'

module Tankard
  module Api
    module Base
      # Base class for routes that can find a specific type of data
      #
      # @author Matthew Shafer
      class Find
        include Tankard::Api::Utils::Find

        def initialize(request, options = {})
          @http_client = request
          @http_request_parameters = options
        end

      private

        attr_reader :http_client, :http_request_parameters
      end
    end
  end
end
