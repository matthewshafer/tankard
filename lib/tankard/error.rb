module Tankard
  module Error
    ConfigurationError = Class.new(::StandardError)
    NoBeerId = Class.new(::StandardError)
    NoStyleId = Class.new(::StandardError)
    HttpError = Class.new(::StandardError)
    LoadError = Class.new(::StandardError)
    InvalidResponse = Class.new(::StandardError)
    ApiKeyUnauthorized = Class.new(::StandardError)
  end
end