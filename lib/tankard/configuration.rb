module Tankard
  # Configuring and validating credentials
  #
  # @author Matthew Shafer
  module Configuration
    attr_writer :api_key

    KEYS = [:api_key]
    BREWERYDB_URL = 'http://api.brewerydb.com/v2/'.freeze

    def configure
      yield self
      validate_api_key!
      reset_client
      self
    end

  private

    def credentials
      {
        api_key: @api_key
      }
    end

    def validate_api_key!
      fail Tankard::Error::ConfigurationError, 'api_key is not a string' unless @api_key.is_a?(String)
    end

    def reset_client
      fail Tankard::Error::ConfigurationError, 'Implement reset_client'
    end
  end
end
