require 'spec_helper'

describe Tankard::Api::Style do
  let(:style) { Tankard::Api::Style.new(@request) }

  before do
    @request = double('request')
  end

  describe '#find' do

    before do
      @request.stub(:get).with('style/1', {}).and_return('data' => 'valid1_found')
      @request.stub(:get).with('style/2', {}).and_return('data' => 'valid2_found')
      @request.stub(:get).with('style/3', {}).and_raise(Tankard::Error::HttpError)
      @request.stub(:get).with('style/4', {}).and_raise(Tankard::Error::HttpError)
    end

    it_should_behave_like 'the find method' do
      let(:context) { style }
      let(:valid_items) { [1, 2] }
      let(:valid_responses) { %w(valid1_found valid2_found) }
      let(:invalid_items) { [3, 4] }
      let(:valid_invalid_items) { valid_items + invalid_items }
    end
  end

  describe '#id' do

    it 'sets the options[:id] for the style id passed in' do
      style.id(1)
      style_options = style.instance_variable_get(:"@http_request_parameters")
      expect(style_options[:id]).to eql(1)
    end

    it 'returns itself' do
      expect(style.object_id).to eql(style.id(1).object_id)
    end
  end

  describe 'when making a request' do

    context 'and the id for a style is not set' do

      it 'raises a Tankard::Error::NoStyleId' do
        expect { style.each { |s| p s } }.to raise_error(Tankard::Error::MissingParameter, 'No style id set')
      end
    end

    context 'and the id for a style is set' do

      before do
        @request.stub(:get).with('style/1', {}).and_return('data' => ['style_valid'])
      end

      it 'uses the style id in the uri' do
        expect(style.id(1).map { |x| x }).to eql(['style_valid'])
      end
    end
  end

  describe 'private methods' do

    describe '#raise_if_no_id_in_options' do

      context 'when an ID is not set' do

        it 'raises Tankard::Error::MissingParameter' do
          expect { style.send(:raise_if_no_id_in_options) }.to raise_error(Tankard::Error::MissingParameter, 'No style id set')
        end
      end

      context 'when an ID is set' do

        before do
          style.instance_variable_get(:"@http_request_parameters")[:id] = 'test'
        end

        it 'returns the id from options' do
          expect(style.send(:raise_if_no_id_in_options)).to eql('test')
        end

        it 'removes the id from options' do
          style.send(:raise_if_no_id_in_options)
          expect(style.instance_variable_get(:"@http_request_parameters")[:id]).to be_nil
        end

        it 'can be called multiple times and not raise error' do
          style.send(:raise_if_no_id_in_options)
          expect { style.send(:raise_if_no_id_in_options) }.not_to raise_error
        end

        it 'caches the ID for future method calls' do
          style.send(:raise_if_no_id_in_options)
          expect(style.send(:raise_if_no_id_in_options)).to eql('test')
        end

        it 'updates the cache value if the user sets a new ID' do
          style.send(:raise_if_no_id_in_options)
          style.instance_variable_get(:"@http_request_parameters")[:id] = 'test1'
          expect(style.send(:raise_if_no_id_in_options)).to eql('test1')
        end
      end
    end

    describe '#route' do

      it 'returns the route for the api request' do
        expect(style.send(:route)).to eql('style')
      end
    end

    describe '#http_request_uri' do

      before do
        style.stub(:route).and_return('style')
        style.stub(:raise_if_no_id_in_options).and_return('123')
      end

      context 'no endpoint is set' do

        it 'returns the route with the id' do
          expect(style.send(:http_request_uri)).to eql('style/123')
        end
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
