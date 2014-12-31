require 'spec_helper'

describe Tankard::Api::Adjuncts do
  let(:adjuncts) { Tankard::Api::Adjuncts.new(@request) }

  before do
    @request = double('request')
  end

  describe '#page' do
    it 'sets the http_request_parameters[:p] for the page number' do
      adjuncts.page(1)
      adjuncts_options = adjuncts.instance_variable_get(:"@http_request_parameters")
      expect(adjuncts_options[:p]).to eql(1)
    end

    it 'returns self' do
      expect(adjuncts.object_id).to eql(adjuncts.page(1).object_id)
    end
  end

  describe '#params' do
    it 'sets parameters' do
      adjuncts.params(p: 5)
      adjuncts_options = adjuncts.instance_variable_get(:"@http_request_parameters")
      expect(adjuncts_options[:p]).to eql(5)
    end

    it 'merges params when called multiple times' do
      adjuncts.params(p: 5)
      adjuncts.params(p: 8)
      adjuncts_options = adjuncts.instance_variable_get(:"@http_request_parameters")
      expect(adjuncts_options[:p]).to eql(8)
    end

    it 'returns itself' do
      expect(adjuncts.object_id).to eql(adjuncts.params.object_id)
    end
  end

  describe 'private method' do
    describe '#http_request_uri' do
      it 'returns the string adjuncts' do
        expect(adjuncts.send(:http_request_uri)).to eql('adjuncts')
      end
    end

    describe '#http_client' do
      it 'returns the request variable that is passed to the class when initialized' do
        expect(adjuncts.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe '#http_request_parameters' do
      it 'returns the http_request_parameters for the request' do
        expect(adjuncts.send(:http_request_parameters).object_id).to eql(adjuncts.instance_variable_get(:"@http_request_parameters").object_id)
      end
    end
  end
end
