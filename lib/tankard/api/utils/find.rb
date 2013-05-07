require 'tankard/api/request/get'

module Tankard
  module Api
    module Utils
      module Find
        include Tankard::Api::Request::Get

        def find(id_or_array, options={})
          @options.merge!(options)

          if id_or_array.is_a?(Array)
            id_or_array.map { |id| request_data_with_nil_on_http_error(@request, "#{route}/#{id}", @options) }.compact
          else
            request_data_with_nil_on_http_error(@request, "#{route}/#{id_or_array}", @options)
          end
        end

        private

          def route
            raise NoMethodError.new("Must implement and return the base route")
          end
      end
    end
  end
end