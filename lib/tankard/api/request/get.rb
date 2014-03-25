module Tankard
  module Api
    module Request
      # Helper for GET requests
      #
      # @author Matthew Shafer
      module Get

      private

        def request_data_with_nil_on_http_error(request_object, uri, options)
          get_request(request_object, uri, options)['data']
        rescue Tankard::Error::HttpError
          nil
        end

        def get_request(request_object, uri, options)
          request_object.get(uri, options)
        end
      end
    end
  end
end
