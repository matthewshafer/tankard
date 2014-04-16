require 'spec_helper'

describe Tankard::Api::Categories do

  let(:categories) { Tankard::Api::Categories.new(@request) }

  before do
    @request = double('request')
  end

  describe 'when making a request' do

    it 'returns the data portion of the request' do
      @request.stub(:get).with('categories', {}).and_return('data' => %w(test1 test2))
      expect(categories.map { |x| x }).to eql(%w(test1 test2))
    end
  end
end
