require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    class Styles
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders

      def initialize(request)
        @request = request
      end

      private

        def http_request_uri
          "styles"
        end

        def http_client
          @request
        end

        def http_request_parameters
          {}
        end
    end
  end
end