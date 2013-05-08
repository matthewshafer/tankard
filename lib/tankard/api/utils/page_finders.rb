require 'tankard/api/request/get'

module Tankard
  module Api
    module Utils
      module PageFinders
        include Tankard::Api::Request::Get

        private
          def find_on_all_pages(uri, request, options, block)
            page = 0
            
            begin
              page += 1
              options[:p] = page
              response = get_request(request, uri, options)
              total_pages = response["numberOfPages"].to_i
              data = response["data"]
              raise Tankard::Error::InvalidResponse unless data
              data.each { |beer| block.call(beer) }
            end while page < total_pages
          end

          def find_on_single_page(uri, request, options, block)
            data = request_data(request, uri, options)
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
end