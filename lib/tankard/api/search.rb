require 'hashie'
require 'tankard/api/utils/page_finders'

module Tankard
  module Api
    # Access for the /search route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/search_index
    # @author Matthew Shafer
    class Search
      include ::Enumerable
      include Tankard::Api::Utils::PageFinders
      # @!parse include ::Enumerable

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Search]
      def initialize(request, options = {})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      # Calls the given block once for each result
      #
      # @yieldparam [Hash] hash containing individual beer information
      # @raise [Tankard::Error::MissingParameter] when the id is not set
      # @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      # @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      # @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      # @raise [Tankard::Error::LoadError] when multi json is unable to decode json
      def each(&block)
        raise_if_required_options_not_set
        super(&block)
      end

      # Query to search for
      #
      # @param search_query [String]
      # @return [self] returns itself
      def query(search_query)
        @options.q = search_query
        self
      end

      # Page number to request
      #
      # @param number [Integer]
      # @return [self] returns itself
      def page(number)
        @options.p = number
        self
      end

      # Additional parameters to send with the request
      #
      # @param options [Hash]
      # @return [self] returns itself
      def params(options = {})
        options.each_pair do |key, value|
          @options[key] = value
        end
        self
      end

      # Type of search to perform
      #
      # @param search_type [String]
      # @return [self] returns itself
      def type(search_type)
        @options.type = search_type
        self
      end

      # search for a specific upc.
      # sets the endpoint to upc and passes upc_code as a parameter
      #
      # @param upc_code [Integer]
      # @return [self] returns itself
      def upc(upc_code)
        @options.code = upc_code
        @options.endpoint = 'upc'
        self
      end

      # search for berweries around a specific point.
      # sets the endpoint to geo/point and passes lat/lng as parameters
      #
      # @param latitude [Float]
      # @param longitude [Float]
      # @return [self] returns itself
      def geo_point(latitude, longitude)
        @options.lat = latitude
        @options.lng = longitude
        @options.endpoint = 'geo/point'
        self
      end

    private

      def http_request_uri
        endpoint = 'search'

        endpoint += "/#{@options.delete(:endpoint)}" if @options.endpoint?

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
          fail Tankard::Error::MissingParameter, 'No search query set' unless @options.q?
        when 'upc'
          fail Tankard::Error::MissingParameter, 'missing parameter: code' unless @options.code?
        when 'geo/point'
          fail Tankard::Error::MissingParameter, 'missing Parameters: lat, lng' unless @options.lat? && @options.lng?
        end
      end
    end
  end
end
