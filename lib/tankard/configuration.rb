module Tankard
  module Configuration
    attr_writer :api_key

    KEYS = [:api_key]
    BREWERYDB_URL = "http://api.brewerydb.com/v2/"

    def configure
      yield self
      validate_api_key!
      self
    end

    def reset!
      Tankard::Configuration::KEYS.each do |key|
        instance_variable_set(:"@{key}", nil)
      end
    end

    private

      def credentials
        {
          api_key: @api_key
        }
      end

      def validate_api_key!
        unless @api_key.is_a?(String)
          raise Tankard::Error::ConfigurationError, "api_key is not a string"
        end
      end
  end
end