require_relative './request'
require_relative './api/beer'
require_relative './api/beers'
require_relative './api/search'
require_relative './api/styles'
require_relative './api/style'
require_relative './api/adjuncts'
require_relative './api/adjunct'
require_relative './api/categories'
require_relative './api/category'
require_relative './api/yeast'
require_relative './api/yeasts'

module Tankard
    # Interaction point for various endpoints
    # When querying Tankard normally there is only one of these alive at a time
    #
    # @author Matthew Shafer
  class Client

    def initialize(options = {})
      Tankard::Configuration::KEYS.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end

      @tankard_request = Tankard::Request.new(@api_key)
    end

    def adjunct(options = {})
      Tankard::Api::Adjunct.new(@tankard_request, options)
    end

    def adjuncts(options = {})
      Tankard::Api::Adjuncts.new(@tankard_request, options)
    end

    def beer(options = {})
      Tankard::Api::Beer.new(@tankard_request, options)
    end

    def beers(options = {})
      Tankard::Api::Beers.new(@tankard_request, options)
    end

    def categories
      Tankard::Api::Categories.new(@tankard_request)
    end

    def category(options = {})
      Tankard::Api::Category.new(@tankard_request, options)
    end

    def search(options = {})
      Tankard::Api::Search.new(@tankard_request, options)
    end

    def styles
      Tankard::Api::Styles.new(@tankard_request)
    end

    def style(options = {})
      Tankard::Api::Style.new(@tankard_request, options)
    end

    def yeast(options = {})
      Tankard::Api::Yeast.new(@tankard_request, options)
    end

    def yeasts(options = {})
      Tankard::Api::Yeasts.new(@tankard_request, options)
    end
  end
end
