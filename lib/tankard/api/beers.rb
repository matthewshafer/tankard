require 'hashie'

module Tankard
  module Api
    class Beers
      include ::Enumerable

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def each(&block)
        if options_have_page_set
          find_on_single_page(block)
        else
          find_on_all_pages(block)
        end
      end

      def name(beer_name)
        @options[:name] = beer_name
        self
      end

      def page(number)
        @options[:p] = number
        self
      end

      private

        def options_have_page_set
          # need to make the keys respond to both symbol and string
          @options.has_key?(:p)
        end

        def find_on_all_pages(block)
          page = 0
          options = @options.clone
          begin
            page += 1
            options[:p] = page
            response = request_with_nil_on_http_error("beers", options)
            total_pages = response["numberOfPages"]
            data = response["data"]
            data.each { |beer| block.call(beer) }
          end while page < total_pages
        end

        def find_on_single_page(block)
          data = request_data_with_nil_on_http_error("beers", @options)
          raise Tankard::Error::InvalidResponse unless data
          
          if data.is_a?(Hash)
            block.call(data)
          else
            data.each { |beer| block.call(beer) }
          end
        end

        def request_data_with_nil_on_error(uri, options)
          request_body = request_with_nil_on_http_error(uri, options)
          request_body ? request_body["data"] : nil
        end

        def request_with_nil_on_http_error(uri, options)
          begin
            @request.get(uri, options)
          rescue Tankard::Error::HttpError
            nil
          end
        end
    end
  end
end