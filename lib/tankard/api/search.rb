require 'hashie'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    class Search
      include ::Enumerable
      include Tankard::Api::Utils::PageFinders

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def each(&block)
        raise_if_required_options_not_set
        super(&block)
      end

      def query(search_query)
        @options.q = search_query
        self
      end

      def page(number)
        @options.p = number
        self
      end

      def params(options={})
        options.each_pair do |key,value|
          @options[key] = value
        end
        self
      end

      def type(search_type)
        @options.type = search_type
        self
      end

      def upc(upc_code)
        @options.code = upc_code
        @options.endpoint = "upc"
        self
      end

      def geo_point(latitude, longitude)
        @options.lat = latitude
        @options.lng = longitude
        @options.endpoint = "geo/point"
        self
      end

      private

        def http_request_uri
          endpoint = "search"

          if @options.endpoint?
            endpoint += "/#{@options.delete(:endpoint)}"
          end

          endpoint
        end

        def http_client
          @request
        end

        def http_request_parameters
          @options
        end

        def raise_if_required_options_not_set
          case @options.endpoint
          when nil
            raise Tankard::Error::NoSearchQuery unless @options.q?
          when "upc"
            raise Tankard::Error::MissingParameter, "missing parameter: code" unless @options.code?
          when "geo/point"
            raise Tankard::Error::MissingParameter, "missing Parameters: lat, lng" unless @options.lat? && @options.lng?
          end
        end
    end
  end
end