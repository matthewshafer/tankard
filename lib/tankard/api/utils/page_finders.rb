require_relative '../../api/request/get'

module Tankard
  module Api
    module Utils
      # Seamless querying of multiple pages of results
      # Allows using any ruby enumerable (EX. map)
      #
      # @author Matthew Shafer
      module PageFinders
        include ::Enumerable
        include Tankard::Api::Request::Get

        # Loads data from brewerydb and calls supplied block with resulting data
        #
        # @yieldparam [Hash] hash containing individual beer information
        def each(&block)
          find_on_single_or_all_pages(http_request_parameters, block)
        end

      private

        def find_on_single_or_all_pages(options, block)
          if options[:p]
            find_on_single_page(options, block)
          else
            find_on_all_pages(options, block)
          end
        end

        def find_on_all_pages(options, block)
          page = 0

          loop do
            page += 1
            options[:p] = page if page > 1
            total_pages = find_on_single_page(options, block)
            break unless page < total_pages
          end
        end

        def find_on_single_page(options, block)
          response = get_request(http_client, http_request_uri, options)
          call_block_with_data(response['data'], block)
          response['numberOfPages'].to_i
        end

        def call_block_with_data(data, block)
          fail Tankard::Error::InvalidResponse unless data

          if data.is_a?(Hash)
            block.call(data)
          else
            data.each { |item| block.call(item) }
          end
        end

        def http_request_uri
          fail NoMethodError, 'Need to implement method'
        end

        def http_client
          fail NoMethodError, 'Need to implement method'
        end

        def http_request_parameters
          fail NoMethodError, 'Need to implement method'
        end
      end
    end
  end
end
