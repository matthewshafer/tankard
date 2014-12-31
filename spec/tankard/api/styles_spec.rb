require 'spec_helper'

describe Tankard::Api::Styles do
  let(:styles) { Tankard::Api::Styles.new(@request) }

  before do
    @request = double('request')
  end

  describe 'when making a request' do
    it 'returns the data portion of the request' do
      @request.stub(:get).with('styles', {}).and_return('data' => %w(test1 test2))
      expect(styles.map { |x| x }).to eql(%w(test1 test2))
    end
  end
end
