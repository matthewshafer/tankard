require 'hashie'

module Tankard
  module Api
    class Beer
      include ::Enumerable

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
          beer_id.map { |beer| request_data_with_nil_on_http_error("beer/#{beer}", @options) }.compact
        else
          request_data_with_nil_on_http_error("beer/#{beer_id}", @options)
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

      private

        def request_data_from_options
          endpoint = "beer/#{raise_if_no_id_in_options}"

          if @options.endpoint?
            endpoint += "/#{@options.delete(:endpoint)}"
          end

          request_data(endpoint, @options)
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

        def request_data_with_nil_on_http_error(uri, options)
          begin
            request_data(uri, options)
          rescue Tankard::Error::HttpError
            nil
          end
        end

        # break up the request methods into smaller pieces
        def request_data(uri, options)
          get_request(uri, options)["data"]
        end

        def get_request(uri, options)
          @request.get(uri, options)
        end
    end
  end
end