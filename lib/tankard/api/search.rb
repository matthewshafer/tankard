require 'tankard/api/base/page_finders'

module Tankard
  module Api
    # Access for the /search route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/search_index
    # @author Matthew Shafer
    class Search < Tankard::Api::Base::PageFinders
      # @!parse include ::Enumerable

      # @!method initialize(request, options = {})
      #   Initializes a new object
      #
      #   @param request [Tankard::Request]
      #   @param options [Hash]
      #   @return [Tankard::Api::Search]

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
        @http_request_parameters[:q] = search_query
        self
      end

      # @!method page(number)
      #   Page number to request
      #
      #   @param number [Integer]
      #   @return [self] returns itself

      # @!method params(options = {})
      #   Additional parameters to send with the request
      #
      #   @param options [Hash]
      #   @return [self] returns itself

      # Type of search to perform
      #
      # @param search_type [String]
      # @return [self] returns itself
      def type(search_type)
        @http_request_parameters[:type] = search_type
        self
      end

      # search for a specific upc.
      # sets the endpoint to upc and passes upc_code as a parameter
      #
      # @param upc_code [Integer]
      # @return [self] returns itself
      def upc(upc_code)
        @http_request_parameters[:code] = upc_code
        @http_request_parameters[:endpoint] = 'upc'.freeze
        self
      end

      # search for a specific style.
      # sets the endpoint to style and passes the query as a parameter (q)
      #
      # @param query [String]
      # @return [self] returns itself
      def style(query)
        @http_request_parameters[:q] = query
        @http_request_parameters[:endpoint] = 'style'.freeze
        self
      end

      # search for berweries around a specific point.
      # sets the endpoint to geo/point and passes lat/lng as parameters
      #
      # @param latitude [Float]
      # @param longitude [Float]
      # @return [self] returns itself
      def geo_point(latitude, longitude)
        @http_request_parameters[:lat] = latitude
        @http_request_parameters[:lng] = longitude
        @http_request_parameters[:endpoint] = 'geo/point'.freeze
        self
      end

    private

      def http_request_uri
        @request_endpoint = "/#{@http_request_parameters.delete(:endpoint)}" if @http_request_parameters[:endpoint]
        endpoint = 'search'.freeze
        endpoint += @request_endpoint if @request_endpoint
        endpoint
      end

      def raise_if_required_options_not_set
        if @http_request_parameters[:endpoint].nil?
          fail Tankard::Error::MissingParameter, 'No search query set' unless @http_request_parameters[:q]
        elsif @http_request_parameters[:endpoint] == 'upc'.freeze
          fail Tankard::Error::MissingParameter, 'missing parameter: code' unless @http_request_parameters[:code]
        elsif @http_request_parameters[:endpoint] == 'geo/point'.freeze
          fail Tankard::Error::MissingParameter, 'missing Parameters: lat, lng' unless @http_request_parameters[:lat] && @http_request_parameters[:lng]
        end
      end
    end
  end
end
