module Tankard
  # Custom errors classes
  #
  # @author Matthew Shafer
  module Error
    ConfigurationError = Class.new(::StandardError)
    MissingParameter = Class.new(::StandardError)
    HttpError = Class.new(::StandardError)
    LoadError = Class.new(::StandardError)
    InvalidResponse = Class.new(::StandardError)
    ApiKeyUnauthorized = Class.new(::StandardError)
  end
end
