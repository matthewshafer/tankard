require 'hashie'
require 'tankard/api/request/get'

module Tankard
  module Api
    class Beers
      include ::Enumerable
      include Tankard::Api::Request::Get

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
          @options.has_key?(:p)
        end

        def find_on_all_pages(block)
          page = 0
          options = @options.clone
          begin
            page += 1
            options[:p] = page
            response = get_request(@request, "beers", options)
            total_pages = response["numberOfPages"].to_i
            data = response["data"]
            raise Tankard::Error::InvalidResponse unless data
            data.each { |beer| block.call(beer) }
          end while page < total_pages
        end

        def find_on_single_page(block)
          data = request_data(@request, "beers", @options)
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