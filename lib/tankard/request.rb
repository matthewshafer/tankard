require 'multi_json'
require 'httpclient'
require 'tankard/error'

module Tankard
  class Request

    def initialize(api_key)
      @http = HTTPClient.new
      @api_key = api_key
    end

    def get(route, params = {})
      params[:key] = @api_key
      request = @http.get(build_request_url(route), params)
      raise_if_status_not_ok(request.status)
      load_json(request.body)
    end

  private

    def raise_if_status_not_ok(status)
      case status
      when 200
        true
      when 401
        fail Tankard::Error::ApiKeyUnauthorized
      else
        fail Tankard::Error::HttpError
      end
    end

    def build_request_url(route)
      Tankard::Configuration::BREWERYDB_URL + route
    end

    def load_json(json_data)
      MultiJson.load(json_data)
    rescue MultiJson::LoadError
      raise Tankard::Error::LoadError
    end
  end
end
