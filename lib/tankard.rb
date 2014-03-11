require 'tankard/version'
require 'tankard/configuration'
require 'tankard/error'
require 'tankard/client'
require 'atomic'

module Tankard
  @client = ::Atomic.new

  class << self
    include Configuration

    def client
      @client.compare_and_swap(nil, Tankard::Client.new(credentials)) unless @client.value
      @client.value
    end

    def respond_to?(method)
      return client.respond_to?(method)
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
