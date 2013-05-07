require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/finders'

module Tankard
  module Api
    class Style
      include ::Enumerable
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::Finders

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def each(&block)
        find_on_single_page("style/#{raise_if_no_id_in_options}", @request, @options, block)
      end

      def find(style_id, options={})
        @options.merge!(options)

        if style_id.is_a?(Array)
          style_id.map { |style| request_data_with_nil_on_http_error(@request, "style/#{style}", @options) }.compact
        else
          request_data_with_nil_on_http_error(@request, "style/#{style_id}", @options)
        end
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
    end
  end
end