require 'tankard/api/request/get'

module Tankard
  module Api
    module Utils
      module Finders
        include Tankard::Api::Request::Get

        private
          def find_on_all_pages(uri, request, options, block)
            page = 0
            # the clone is here just in case someone decides to create an api class of their own
            # and not go through client.  If they re-use the api class they have created then
            # we would possibably have additional options set that they would reuse with subsequent calls
            # honestly though no one should ever create an api class of their own to use, its a bad idea
            # might pull out this clone at some point
            options = options.clone
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