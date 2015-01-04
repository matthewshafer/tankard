require 'spec_helper'

describe Tankard::Api::Utils::PageFinders do
  let(:finders) { Class.new { include Tankard::Api::Utils::PageFinders }.new }

  describe 'private methods' do
    before do
      @request = double('request')
    end

    describe '#http_request_uri' do
      it 'raises NoMethodError' do
        expect { finders.send(:http_request_uri) }.to raise_error(NoMethodError)
      end
    end

    describe '#http_client' do
      it 'raises NoMethodError' do
        expect { finders.send(:http_client) }.to raise_error(NoMethodError)
      end
    end

    describe '#http_request_parameters' do
      it 'raises NoMethodError' do
        expect { finders.send(:http_request_parameters) }.to raise_error(NoMethodError)
      end
    end

    describe '#call_block_with_data' do
      it 'raises Tankard::Error::InvalidResponse when no data' do
        expect { finders.send(:call_block_with_data, nil, nil) }.to raise_error(Tankard::Error::InvalidResponse)
      end

      it 'accepts a hash of data' do
        result = []
        block = -> n { result.push(n) }
        finders.send(:call_block_with_data, { 'test' => 'something' }, block)
        expect(result).to eql([{ 'test' => 'something' }])
      end

      it 'loops through an array of data' do
        result = []
        block = -> n { result.push(n + 1) }
        finders.send(:call_block_with_data, [1, 2, 3], block)
        expect(result).to eql([2, 3, 4])
      end
    end

    describe '#find_on_single_page' do
      before do
        finders.stub(:http_request_uri).and_return('test')
        finders.stub(:http_client).and_return(@request)
        finders.stub(:call_block_with_data).with(['test'], nil)
      end

      it 'sends response[data] to call_block_with_data' do
        finders.stub(:get_request).and_return('data' => ['test'])
        finders.send(:find_on_single_page, {}, nil)
      end

      it 'returns 0 when number of pages is not set' do
        finders.stub(:get_request).and_return('data' => ['test'])
        expect(finders.send(:find_on_single_page, {}, nil)).to eql(0)
      end

      it 'returns a value when number of pages is set' do
        finders.stub(:get_request).and_return('data' => ['test'], 'numberOfPages' => '3')
        expect(finders.send(:find_on_single_page, {}, nil)).to eql(3)
      end
    end

    describe '#find_on_all_pages' do
      it 'only sets the page when the page is greater than 1' do
        finders.should_receive(:find_on_single_page).with({}, nil).and_return(2)
        finders.should_not_receive(:find_on_single_page).with({ p: 1 }, nil)
        finders.should_receive(:find_on_single_page).with({ p: 2 }, nil).and_return(2)

        finders.send(:find_on_all_pages, {}, nil)
      end
    end

    describe '#find_on_single_or_all_pages' do
      it 'calls find_with_options when a page is set in options' do
        finders.should_receive(:find_on_single_page).with({ p: 2 }, nil)
        finders.send(:find_on_single_or_all_pages, { p: 2 }, nil)
      end

      it 'calls find_on_all_pages when a page is not set in options' do
        finders.should_receive(:find_on_all_pages).with({}, nil)
        finders.send(:find_on_single_or_all_pages, {}, nil)
      end
    end

    describe '#each' do
      before do
        finders.stub(:http_request_uri).and_return('test')
        finders.stub(:http_client).and_return(nil)
        finders.stub(:http_request_parameters).and_return({})
      end

      it 'calls find_on_single_or_all_pages' do
        finders.should_receive(:find_on_single_or_all_pages).with({}, nil)
        finders.each
      end
    end
  end
end
