require 'tankard/version'
require 'tankard/configuration'
require 'tankard/error'
require 'tankard/client'
require 'atomic'

# Sets up and delegates 'most' method calls to the Tankard Client
#
# @author Matthew Shafer
module Tankard
  @client = ::Atomic.new(nil)

  class << self
    include Configuration

    def client
      tankard_client = nil

      loop do
        tankard_client = @client.value
        break if tankard_client
        @client.compare_and_swap(nil, Tankard::Client.new(credentials))
      end

      tankard_client
    end

    def respond_to?(method)
      client.respond_to?(method)
    end

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

    def reset_client
      @client.value = nil
    end
  end
end
