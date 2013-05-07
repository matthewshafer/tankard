require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    class Styles
      include ::Enumerable
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders

      def initialize(request)
        @request = request
      end

      def each(&block)
        find_on_single_page("styles", @request, nil, block)
      end
    end
  end
end