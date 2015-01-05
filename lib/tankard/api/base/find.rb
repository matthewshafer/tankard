require 'hashie'
require 'tankard/api/utils/find'

module Tankard
  module Api
    module Base
      class Find
        include Tankard::Api::Utils::Find

        def initialize(request, options = {})
          @http_client = request
          @http_request_parameters = Hashie::Mash.new(options)
        end

      private

        attr_reader :http_client
        attr_reader :http_request_parameters
      end
    end
  end
end
