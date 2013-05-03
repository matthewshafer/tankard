require 'hashie'
require 'tankard/api/request/get'

module Tankard
  module Api
    class Beer
      include ::Enumerable
      include Tankard::Api::Request::Get

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def each(&block)
        find_on_single_page(block)
      end

      def find(beer_id, options={})
        @options.merge!(options)

        if beer_id.is_a?(Array)
          beer_id.map { |beer| request_data_with_nil_on_http_error(@request, "beer/#{beer}", @options) }.compact
        else
          request_data_with_nil_on_http_error(@request, "beer/#{beer_id}", @options)
        end
      end

      def id(beer_id)
        @options.id = beer_id
        self
      end

      def breweries
        @options.endpoint = "breweries"
        self
      end

      def events
        @options.endpoint = "events"
        self
      end

      def ingredients
        @options.endpoint = "ingredients"
        self
      end

      def social_accounts
        @options.endpoint = "socialaccounts"
        self
      end

      def variations
        @options.endpoint = "variations"
        self
      end

      def params(options={})
        options.each_pair do |key,value|
          @options[key] = value
        end
        self
      end

      private

        def request_data_from_options
          endpoint = "beer/#{raise_if_no_id_in_options}"

          if @options.endpoint?
            endpoint += "/#{@options.delete(:endpoint)}"
          end

          request_data(@request, endpoint, @options)
        end

        def raise_if_no_id_in_options
          raise Tankard::Error::NoBeerId unless @options.id?
          @options.delete(:id)
        end

        def find_on_single_page(block)
          data = request_data_from_options
          raise Tankard::Error::InvalidResponse unless data

          if data.is_a?(Hash)
            block.call(data)
          else
            data.each { |beer| block.call(beer) }
          end
        end
    end
  end
end