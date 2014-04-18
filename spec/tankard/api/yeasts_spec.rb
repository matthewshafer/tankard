require 'spec_helper'

describe Tankard::Api::Yeasts do
  let(:yeasts) { Tankard::Api::Yeasts.new(@request) }

  before do
    @request = double('request')
  end

  describe '#page' do

    it 'sets the options[:p] to request a specific page' do
      yeasts.page(2)
      yeasts_options = yeasts.instance_variable_get(:"@http_request_parameters")
      expect(yeasts_options[:p]).to eql(2)
    end

    it 'returns itself' do
      expect(yeasts.object_id).to eql(yeasts.page(3).object_id)
    end
  end

  describe 'private methods' do

    describe '#http_request_uri' do

      it 'returns the route for the api request' do
        expect(yeasts.send(:http_request_uri)).to eql('yeasts')
      end
    end

    describe '#http_client' do

      it 'returns the request variable that is passed when the class is created' do
        expect(yeasts.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe '#http_request_parameters' do

      it 'returns the options for the request' do
        expect(yeasts.send(:http_request_parameters).object_id).to eql(yeasts.instance_variable_get(:"@http_request_parameters").object_id)
      end
    end
  end
end
