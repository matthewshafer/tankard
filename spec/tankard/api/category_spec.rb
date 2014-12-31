require 'spec_helper'

describe Tankard::Api::Category do
  let(:category) { Tankard::Api::Category.new(@request) }

  before do
    @request = double('request')
  end

  describe '#find' do
    before do
      @request.stub(:get).with('category/1', {}).and_return('data' => 'valid1_found')
      @request.stub(:get).with('category/2', {}).and_return('data' => 'valid2_found')
      @request.stub(:get).with('category/3', {}).and_raise(Tankard::Error::HttpError)
      @request.stub(:get).with('category/4', {}).and_raise(Tankard::Error::HttpError)
    end

    it_should_behave_like 'the find method' do
      let(:context) { category }
      let(:valid_items) { [1, 2] }
      let(:valid_responses) { %w(valid1_found valid2_found) }
      let(:invalid_items) { [3, 4] }
      let(:valid_invalid_items) { valid_items + invalid_items }
    end
  end

  describe 'private methods' do
    describe '#route' do
      it 'returns the route for the http request' do
        expect(category.send(:route)).to eql('category')
      end
    end

    describe '#http_client' do
      it 'returns the object to make a http request' do
        expect(category.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe '#http_request_parameters' do
      it 'returns the request parameters to be passed with the request' do
        expect(category.send(:http_request_parameters).object_id).to eql(category.instance_variable_get(:"@http_request_parameters").object_id)
      end
    end
  end
end
