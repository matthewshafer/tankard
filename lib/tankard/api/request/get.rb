module Tankard
  module Api
    module Request
      module Get

      private

        def request_data_with_nil_on_http_error(request_object, uri, options)
          request_data(request_object, uri, options)
        rescue Tankard::Error::HttpError
          nil
        end

        # break up the request methods into smaller pieces
        def request_data(request_object, uri, options)
          get_request(request_object, uri, options)['data']
        end

        def get_request(request_object, uri, options)
          request_object.get(uri, options)
        end
      end
    end
  end
end
