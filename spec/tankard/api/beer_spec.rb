require 'spec_helper'

RSpec.describe Tankard::Api::Beer do
  let(:beer) { Tankard::Api::Beer.new(@request) }

  before do
    @request = double('request')
  end

  describe '#find' do
    before do
      allow(@request).to receive(:get).with('beer/valid1', {}).and_return('data' => 'valid1_found')
      allow(@request).to receive(:get).with('beer/valid2', {}).and_return('data' => 'valid2_found')
      allow(@request).to receive(:get).with('beer/invalid1', {}).and_raise(Tankard::Error::HttpError)
      allow(@request).to receive(:get).with('beer/invalid2', {}).and_raise(Tankard::Error::HttpError)
    end

    it_should_behave_like 'the find method' do
      let(:context) { beer }
      let(:valid_items) { %w(valid1 valid2) }
      let(:valid_responses) { %w(valid1_found valid2_found) }
      let(:invalid_items) { %w(invalid1 invalid2) }
      let(:valid_invalid_items) { valid_items + invalid_items }
    end
  end

  describe '#id' do
    it 'sets the options[:id] to the beer id passed in' do
      beer.id('port')
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:id]).to eql('port')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.id('port').object_id)
    end
  end

  describe '#adjuncts' do
    it 'sets the options[:endpoint] to adjuncts' do
      beer.adjuncts
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('adjuncts')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.adjuncts.object_id)
    end
  end

  describe '#breweries' do
    it 'sets the options[:endpoint] to breweries' do
      beer.breweries
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('breweries')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.breweries.object_id)
    end
  end

  describe '#events' do
    it 'sets the options[:endpoint] to events' do
      beer.events
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('events')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.events.object_id)
    end
  end

  describe '#fermentables' do
    it 'sets the options[:endpoint] to fermentables' do
      beer.fermentables
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('fermentables')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.fermentables.object_id)
    end
  end

  describe '#hops' do
    it 'sets the options[:endpoint] to hops' do
      beer.hops
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('hops')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.hops.object_id)
    end
  end

  describe '#ingredients' do
    it 'sets the options[:endpoint] to ingredients' do
      beer.ingredients
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('ingredients')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.ingredients.object_id)
    end
  end

  describe '#social_accounts' do
    it 'sets the options[:endpoint] to socialaccounts' do
      beer.social_accounts
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('socialaccounts')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.social_accounts.object_id)
    end
  end

  describe '#upcs' do
    it 'sets the options[:endpoint] to upcs' do
      beer.upcs
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('upcs')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.upcs.object_id)
    end
  end

  describe '#variations' do
    it 'sets the options[:endpoint] to variations' do
      beer.variations
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('variations')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.variations.object_id)
    end
  end

  describe '#yeasts' do
    it 'sets the options[:endpoint] to yeasts' do
      beer.yeasts
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:endpoint]).to eql('yeasts')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.yeasts.object_id)
    end
  end

  describe '#params' do
    it 'sets parameters' do
      beer.params(withSocialAccounts: 'y', withGuilds: 'n')
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:withSocialAccounts]).to eql('y')
      expect(beer_options[:withGuilds]).to eql('n')
    end

    it 'merges data when called multiple times' do
      beer.params(test: 'n')
      beer.params(test: 'y')
      beer_options = beer.instance_variable_get(:"@http_request_parameters")
      expect(beer_options[:test]).to eql('y')
    end

    it 'returns itself' do
      expect(beer.object_id).to eql(beer.params.object_id)
    end
  end

  describe 'private methods' do
    describe '#raise_if_no_id_in_options' do
      context 'when an ID is not set' do
        it 'raises Tankard::Error::MissingParameter' do
          expect { beer.send(:raise_if_no_id_in_options) }.to raise_error(Tankard::Error::MissingParameter, 'No Beer ID is set')
        end
      end

      context 'when an ID is set' do
        before do
          beer.instance_variable_get(:"@http_request_parameters")[:id] = 'test'
        end

        it 'returns the id from options' do
          expect(beer.send(:raise_if_no_id_in_options)).to eql('test')
        end

        it 'removes the id from options' do
          beer.send(:raise_if_no_id_in_options)
          expect(beer.instance_variable_get(:"@http_request_parameters")[:id]).to be_nil
        end

        it 'can be called multiple times and not raise error' do
          beer.send(:raise_if_no_id_in_options)
          expect { beer.send(:raise_if_no_id_in_options) }.not_to raise_error
        end

        it 'caches the ID for future method calls' do
          beer.send(:raise_if_no_id_in_options)
          expect(beer.send(:raise_if_no_id_in_options)).to eql('test')
        end

        it 'updates the cache value if the user sets a new ID' do
          beer.send(:raise_if_no_id_in_options)
          beer.instance_variable_get(:"@http_request_parameters")[:id] = 'test1'
          expect(beer.send(:raise_if_no_id_in_options)).to eql('test1')
        end
      end
    end

    describe '#route' do
      it 'returns the route for the api request' do
        expect(beer.send(:route)).to eql('beer')
      end
    end

    describe '#http_request_uri' do
      before do
        allow(beer).to receive(:route).and_return('beer')
        allow(beer).to receive(:raise_if_no_id_in_options).and_return('123')
      end

      context 'no endpoint is set' do
        it 'returns the route with the id' do
          expect(beer.send(:http_request_uri)).to eql('beer/123')
        end
      end

      context 'endpoint is set' do
        before do
          beer.instance_variable_get(:"@http_request_parameters")[:endpoint] = 'events'
        end

        it 'returns the route with the id and endpoint' do
          expect(beer.send(:http_request_uri)).to eql('beer/123/events')
        end

        it 'removes the endpoint from options' do
          beer.send(:http_request_uri)
          expect(beer.instance_variable_get(:"@http_request_parameters")[:endpoint]).to be_nil
        end

        it 'caches the endpoint for future method calls' do
          beer.send(:http_request_uri)
          expect(beer.send(:http_request_uri)).to eql('beer/123/events')
        end

        it 'updates the cached endpoint if the user sets a new one' do
          beer.send(:http_request_uri)
          beer.instance_variable_get(:"@http_request_parameters")[:endpoint] = 'breweries'
          expect(beer.send(:http_request_uri)).to eql('beer/123/breweries')
        end
      end
    end

    describe '#http_client' do
      it 'returns the request variable that is passed when the class is created' do
        expect(beer.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe '#http_request_parameters' do
      it 'returns the options for the request' do
        expect(beer.send(:http_request_parameters).object_id).to eql(beer.instance_variable_get(:"@http_request_parameters").object_id)
      end
    end
  end
end
