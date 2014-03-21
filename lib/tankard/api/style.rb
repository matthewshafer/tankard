require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/page_finders'
require 'tankard/api/utils/find'

module Tankard
  module Api
    # Access for the /style route on brewerydb
    #
    # @see http://www.brewerydb.com/developers/docs-endpoint/style_index
    # @author Matthew Shafer
    class Style
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::PageFinders
      include Tankard::Api::Utils::Find
      # @!parse include ::Enumerable

      # Initializes a new object
      #
      # @param request [Tankard::Request]
      # @param options [Hash]
      # @return [Tankard::Api::Style]
      def initialize(request, options = {})
        @http_client = request
        @http_request_parameters = Hashie::Mash.new(options)
      end

      # @!method find(id_or_array, options={})
      #   Find a single or multiple styles by their id
      #
      #   @param id_or_array [String, Array]
      #   @param options [Hash]
      #   @return [Hash, Array] if a string with a style id is passed to find then the hash of the style is returned.
      #     if an array is passed to find an array containing hashes with each style is returned.
      #     if a style is not found nothing for that style is returned.

      # @!method each(&block)
      #   Calls the given block once for each style
      #
      #   @yieldparam [Hash] hash containing individual style information
      #   @raise [Tankard::Error::MissingParameter] when the id is not set
      #   @raise [Tankard::Error::ApiKeyUnauthorized] when an api key is not valid
      #   @raise [Tankard::Error::InvalidResponse] when no data is returned fron the api
      #   @raise [Tankard::Error::HttpError] when a status other than 200 or 401 is returned
      #   @raise [Tankard::Error::LoadError] when multi json is unable to decode json

      # Style id to query
      #
      # @param style_id [String]
      # @return [self] returns itself
      def id(style_id)
        @http_request_parameters.id = style_id
        self
      end

    private

      attr_reader :http_client
      attr_reader :http_request_parameters

      def raise_if_no_id_in_options
        @style_id = @http_request_parameters.delete(:id) if @http_request_parameters.id?
        fail Tankard::Error::MissingParameter, 'No style id set' unless @style_id
        @style_id
      end

      def route
        'style'
      end

      def http_request_uri
        "#{route}/#{raise_if_no_id_in_options}"
      end
    end
  end
end
