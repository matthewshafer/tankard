require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'
require 'tankard/api/utils/find'

module Tankard
  module Api
    class Style
      include ::Enumerable
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders
      include Tankard::Api::Utils::Find

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def each(&block)
        find_on_single_page("style/#{raise_if_no_id_in_options}", @request, @options, block)
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
    end
  end
end