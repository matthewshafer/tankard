require 'spec_helper'

describe Tankard::Api::Adjunct do
  let(:adjunct) { Tankard::Api::Adjunct.new(@request) }

  before do
    @request = double('request')
  end

  describe '#find' do

    before do
      @request.stub(:get).with('adjunct/valid1', {}).and_return('data' => 'valid1_found')
      @request.stub(:get).with('adjunct/valid2', {}).and_return('data' => 'valid2_found')
      @request.stub(:get).with('adjunct/invalid1', {}).and_raise(Tankard::Error::HttpError)
      @request.stub(:get).with('adjunct/invalid2', {}).and_raise(Tankard::Error::HttpError)
    end

    it_should_behave_like 'the find method' do
      let(:context) { adjunct }
      let(:valid_items) { %w(valid1 valid2) }
      let(:valid_responses) { %w(valid1_found valid2_found) }
      let(:invalid_items) { %w(invalid1 invalid2) }
      let(:valid_invalid_items) { valid_items + invalid_items }
    end
  end
end
