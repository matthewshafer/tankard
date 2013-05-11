require 'tankard/api/request/get'

module Tankard
  module Api
    module Utils
      module PageFinders
        include ::Enumerable
        include Tankard::Api::Request::Get

        def each(&block)
          find_on_single_or_all_pages(http_request_uri, http_client, http_request_parameters, block)
        end

        private

          def find_on_single_or_all_pages(uri, request, options, block)
            if options[:p]
              find_on_single_page(uri, request, options, block)
            else
              find_on_all_pages(uri, request, options, block)
            end
          end

          def find_on_all_pages(uri, request, options, block)
            page = 0

            begin
              page += 1
              options[:p] = page if page > 1
              total_pages = find_on_single_page(uri, request, options, block)
            end while page < total_pages
          end

          def find_on_single_page(uri, request, options, block)
            response = get_request(request, uri, options)
            call_block_with_data(response["data"], block)
            response["numberOfPages"].to_i
          end

          def call_block_with_data(data, block)
            raise Tankard::Error::InvalidResponse unless data

            if data.is_a?(Hash)
              block.call(data)
            else
              data.each { |item| block.call(item) }
            end
          end

          def http_request_uri
            raise NoMethodError.new("Need to implement method")
          end

          def http_client
            raise NoMethodError.new("Need to implement method")
          end

          def http_request_parameters
            raise NoMethodError.new("Need to implement method")
          end
      end
    end
  end
end