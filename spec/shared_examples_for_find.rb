require 'spec_helper'

RSpec.shared_examples_for 'the find method' do
  context 'when looking up a valid item' do
    it 'returns data on the item' do
      expect(context.find(valid_items.first)).to eql(valid_responses.first)
    end
  end

  context 'when looking up an invalid item' do
    it 'returns nil when not found' do
      expect(context.find(invalid_items.first)).to eql(nil)
    end
  end

  context 'when looking up multiple valid items' do
    it 'returns an array of data with each item' do
      expect(context.find(valid_items)).to eql(valid_responses)
    end
  end

  context 'when looking up multiple items and one is invalid' do
    it 'returns an array with only the valid items' do
      expect(context.find(valid_invalid_items)).to eql(valid_responses)
    end
  end
end
