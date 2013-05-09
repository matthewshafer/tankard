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

  describe "#search" do

    context "when called" do

      it "does not reuse an existing search object" do
        search = client.search
        expect(search.object_id).not_to eql(client.search.object_id)
      end
    end

    context "when passed a hash of options" do

      before do
        @request = mock("request")
        Tankard::Request.stub!(:new).and_return(@request)
      end

      it "passes the options to the search object" do
        Tankard::Api::Search.should_receive(:new).with(@request, { test: 123 })
        client.search({ test: 123 })
      end
    end
  end

  describe "#styles" do

    context "when called" do

      it "does not reuse an existing styles object" do
        styles = client.styles
        expect(styles.object_id != client.styles.object_id).to be_true
      end
    end
  end

  describe "#style" do

    context "when called" do

      it "does not reuse an existing style object" do
        style = client.style
        expect(style.object_id).not_to eql(client.style.object_id)
      end
    end

    context "when passed a hash of options" do

      before do
        @request = mock("request")
        Tankard::Request.stub!(:new).and_return(@request)
      end

      it "passes the options to the style object" do
        Tankard::Api::Style.should_receive(:new).with(@request, { test: 123 })
        client.style({ test: 123 })
      end
    end
  end
end