require 'hashie'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    module Base
      # Base class for routes that can look up data across pages
      #
      # @author Matthew Shafer
      class PageFinders
        include Tankard::Api::Utils::PageFinders

        def initialize(request, options = {})
          @http_client = request
          @http_request_parameters = Hashie::Mash.new(options)
        end

        def page(number)
          @http_request_parameters.p = number
          self
        end

        def params(options = {})
          options.each_pair do |key, value|
            @http_request_parameters[key] = value
          end
          self
        end

      private

        attr_reader :http_client, :http_request_parameters
      end
    end
  end
end
