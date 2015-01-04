require 'spec_helper'

describe Tankard do
  context 'when delegating to a client' do
    before do
      allow_any_instance_of(Tankard::Client).to receive(:test).and_return('testing')
    end

    it 'delegates to Tankard::Client' do
      expect(Tankard.test).to eql('testing')
    end

    describe '.respond_to?' do
      it 'delegates to Tankard::Client' do
        expect(Tankard.respond_to?(:test)).to be_truthy
      end
    end

    describe '.client' do
      it 'returns a Tankard::Client' do
        expect(Tankard.client).to be_kind_of(Tankard::Client)
      end

      it 'does not create a new Tankard::Client when one is already created' do
        client = Tankard.client
        expect(Tankard.client).to eql(client)
      end
    end
  end

  describe '.configuration' do
    context 'when invalid configuration data is provided' do
      it 'raises a configuration error' do
        expected_error = expect do
          Tankard.configure do |config|
            config.api_key = 1234
          end
        end

        expected_error.to raise_error(Tankard::Error::ConfigurationError)
      end
    end

    context 'when valid configuration data is provided' do
      before do
        Tankard.configure do |config|
          config.api_key = 'abc123'
        end
      end

      it 'sets the api_key' do
        expect(Tankard.instance_variable_get(:"@api_key")).to eql('abc123')
      end
    end
  end
end
