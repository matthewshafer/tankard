require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'
require 'tankard/api/utils/find'

module Tankard
  module Api
    class Style
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders
      include Tankard::Api::Utils::Find

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def id(style_id)
        @options.id = style_id
        self
      end

      private

        def raise_if_no_id_in_options
          raise Tankard::Error::NoStyleId unless @options.id?
          @options.delete(:id)
        end

        def route
          "style"
        end

        def http_request_uri
          "#{route}/#{raise_if_no_id_in_options}"
        end

        def http_client
          @request
        end

        def http_request_parameters
          @options
        end
    end
  end
end