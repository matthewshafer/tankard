require 'hashie'
require 'tankard/api/request/get'
require 'tankard/api/utils/finders'

module Tankard
  module Api
    class Beers
      include ::Enumerable
      include Tankard::Api::Request::Get
      include Tankard::Api::Utils::Finders

      def initialize(request, options={})
        @request = request
        @options = Hashie::Mash.new(options)
      end

      def each(&block)
        if options_have_page_set
          find_on_single_page("beers", @request, @options, block)
        else
          find_on_all_pages("beers", @request, @options,block)
        end
      end

      def name(beer_name)
        @options[:name] = beer_name
        self
      end

      def page(number)
        @options[:p] = number
        self
      end

      private

        def options_have_page_set
          @options.has_key?(:p)
        end
    end
  end
end