require 'tankard/api/request/get'

module Tankard
  module Api
    module Utils
      # Helper for finding one or more things by ID(s)
      #
      # @author Matthew Shafer
      module Find
        include Tankard::Api::Request::Get

        def find(id_or_array, options = {})
          options = http_request_parameters.merge!(options)

          if id_or_array.is_a?(Array)
            id_or_array.map { |id| request_data_with_nil_on_http_error(http_client, "#{route}/#{id}", options) }.compact
          else
            request_data_with_nil_on_http_error(http_client, "#{route}/#{id_or_array}", options)
          end
        end

      private

        def route
          fail NoMethodError, 'Must implement and return the base route'
        end

        def http_client
          fail NoMethodError, 'Must return the http object to make requests with'
        end

        def http_request_parameters
          fail NoMethodError, 'Must return a hash like structure with request parameters'
        end
      end
    end
  end
end
