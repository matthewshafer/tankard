require 'spec_helper'

RSpec.describe Tankard::Client do
  let(:client) { Tankard::Client.new(api_key: 'abc123') }

  describe '#adjunct' do
    context 'when called' do
      it 'does not reuse an existing adjunct object' do
        first_adjunct = client.adjunct
        expect(first_adjunct.object_id).to_not eql(client.adjunct.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the beer object' do
        expect(Tankard::Api::Adjunct).to receive(:new).with(@request, test: 123)
        client.adjunct(test: 123)
      end
    end
  end

  describe '#adjuncts' do
    context 'when called' do
      it 'does not reuse an existing adjuncts object' do
        first_adjuncts = client.adjuncts
        expect(first_adjuncts.object_id).to_not eql(client.adjuncts.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the beer object' do
        expect(Tankard::Api::Adjuncts).to receive(:new).with(@request, test: 123)
        client.adjuncts(test: 123)
      end
    end
  end

  describe '#beer' do
    context 'when called' do
      it 'does not reuse an existing beer object' do
        first_beer = client.beer
        expect(first_beer.object_id).to_not eql(client.beer.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the beer object' do
        expect(Tankard::Api::Beer).to receive(:new).with(@request, test: 123)
        client.beer(test: 123)
      end
    end
  end

  describe '#beers' do
    context 'when called' do
      it 'does not reuse an existing beer object' do
        beers = client.beers
        expect(beers.object_id).to_not eql(client.beers.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the beer object' do
        expect(Tankard::Api::Beers).to receive(:new).with(@request, test: 123)
        client.beers(test: 123)
      end
    end
  end

  describe '#categories' do
    context 'when called' do
      it 'does not reuse an existing categories object' do
        categories = client.categories
        expect(categories.object_id).to_not eql(client.categories.object_id)
      end
    end
  end

  describe '#category' do
    context 'when called' do
      it 'does not reuse an existing category object' do
        category = client.category
        expect(category.object_id).not_to eql(client.category.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the category object' do
        expect(Tankard::Api::Category).to receive(:new).with(@request, test: 123)
        client.category(test: 123)
      end
    end
  end

  describe '#search' do
    context 'when called' do
      it 'does not reuse an existing search object' do
        search = client.search
        expect(search.object_id).not_to eql(client.search.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the search object' do
        expect(Tankard::Api::Search).to receive(:new).with(@request, test: 123)
        client.search(test: 123)
      end
    end
  end

  describe '#styles' do
    context 'when called' do
      it 'does not reuse an existing styles object' do
        styles = client.styles
        expect(styles.object_id).not_to eql(client.styles.object_id)
      end
    end
  end

  describe '#style' do
    context 'when called' do
      it 'does not reuse an existing style object' do
        style = client.style
        expect(style.object_id).not_to eql(client.style.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the style object' do
        expect(Tankard::Api::Style).to receive(:new).with(@request, test: 123)
        client.style(test: 123)
      end
    end
  end

  describe '#yeast' do
    context 'when called' do
      it 'does not reuse an existing yeast object' do
        yeast = client.yeast
        expect(yeast.object_id).not_to eql(client.yeast.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options ot the yeast object' do
        expect(Tankard::Api::Yeast).to receive(:new).with(@request, test: 123)
        client.yeast(test: 123)
      end
    end
  end

  describe '#yeasts' do
    context 'when called' do
      it 'does not reuse an existing yeasts object' do
        yeasts = client.yeasts
        expect(yeasts.object_id).not_to eql(client.yeasts.object_id)
      end
    end

    context 'when passed a hash of options' do
      before do
        @request = double('request')
        allow(Tankard::Request).to receive(:new).and_return(@request)
      end

      it 'passes the options to the yeasts object' do
        expect(Tankard::Api::Yeasts).to receive(:new).with(@request, test: 123)
        client.yeasts(test: 123)
      end
    end
  end
end
