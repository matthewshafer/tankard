require 'spec_helper'

describe Tankard::Client do

  let(:client) { Tankard::Client.new({api_key: "abc123"}) }

  describe "#beer" do

    context "when called" do

      it "does not reuse an existing beer object" do
        first_beer = client.beer
        expect(first_beer.object_id != client.beer.object_id).to be_true
      end
    end

    context "when passed a hash of options" do

      before do
        @request = mock("request")
        Tankard::Request.stub!(:new).and_return(@request)
      end

      it "passes the options to the beer object" do
        Tankard::Api::Beer.should_receive(:new).with(@request, {test: 123})
        client.beer({test: 123})
      end
    end
  end

  describe "#beers" do

    context "when called" do

      it "does not reuse an existing beer object" do
        beers = client.beers
        expect(beers.object_id != client.beers.object_id).to be_true
      end
    end

    context "when passed a hash of options" do

      before do 
        @request = mock("request")
        Tankard::Request.stub!(:new).and_return(@request)
      end

      it "passes the options to the beer object" do
        Tankard::Api::Beers.should_receive(:new).with(@request, {test: 123})
        client.beers({test: 123})
      end
    end
  end
end