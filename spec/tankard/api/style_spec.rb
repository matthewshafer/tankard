require 'spec_helper'

RSpec.describe Tankard::Api::Style do
  let(:style) { Tankard::Api::Style.new(@request) }

  before do
    @request = double('request')
  end

  describe '#find' do
    before do
      allow(@request).to receive(:get).with('style/1', {}).and_return('data' => 'valid1_found')
      allow(@request).to receive(:get).with('style/2', {}).and_return('data' => 'valid2_found')
      allow(@request).to receive(:get).with('style/3', {}).and_raise(Tankard::Error::HttpError)
      allow(@request).to receive(:get).with('style/4', {}).and_raise(Tankard::Error::HttpError)
    end

    it_should_behave_like 'the find method' do
      let(:context) { style }
      let(:valid_items) { [1, 2] }
      let(:valid_responses) { %w(valid1_found valid2_found) }
      let(:invalid_items) { [3, 4] }
      let(:valid_invalid_items) { valid_items + invalid_items }
    end
  end

  describe 'private methods' do
    describe '#route' do
      it 'returns the route for the api request' do
        expect(style.send(:route)).to eql('style')
      end
    end

    describe '#http_client' do
      it 'returns the request variable that is passed when the class is created' do
        expect(style.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe '#http_request_parameters' do
      it 'returns the options for the request' do
        expect(style.send(:http_request_parameters).object_id).to eql(style.instance_variable_get(:"@http_request_parameters").object_id)
      end
    end
  end
end
