require 'spec_helper'

describe Tankard::Api::Beer do

  let(:beer) { Tankard::Api::Beer.new(@request) }

  before do
    @request = mock("request")
  end

  describe "#find" do

    before do
      @valid_beers = ["valid1", "valid2"]
      @invalid_beers = ["invalid1", "invalid2"]
      @request.stub(:get).with("beer/valid1", {}).and_return({ "data" => "valid1_found"})
      @request.stub(:get).with("beer/valid2", {}).and_return({ "data" => "valid2_found"})
      @request.stub(:get).with("beer/invalid1", {}).and_raise(Tankard::Error::HttpError)
      @request.stub(:get).with("beer/invalid2", {}).and_raise(Tankard::Error::HttpError)
    end

    context "when looking up a valid beer" do

      it "returns data on that specific beer" do
        expect(beer.find(@valid_beers.first)).to eql("valid1_found")
      end
    end

    context "when looking up an invalid beer" do

      it "returns nil when not found" do
        expect(beer.find(@invalid_beers.first)).to eql(nil)
      end
    end

    context "when looking up multiple valid beers" do

      it "returns an array of data with each beer" do
        expect(beer.find(@valid_beers)).to eql(["valid1_found", "valid2_found"])
      end
    end

    context "when looking up multiple beers and one is invalid" do

      it "returns an array with only the valid beers" do
        beer_request = @valid_beers + @invalid_beers
        expect(beer.find(beer_request)).to eql(["valid1_found", "valid2_found"])
      end
    end
  end

  describe "#id" do

    it "sets the options[:id] to the beer id passed in" do
      beer.id("port")
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:id]).to eql("port")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.id("port").object_id)
    end
  end

  describe "#breweries" do

    it "sets the options[:endpoint] to breweries" do
      beer.breweries
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:endpoint]).to eql("breweries")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.breweries.object_id)
    end
  end

  describe "#events" do

    it "sets the options[:endpoint] to events" do
      beer.events
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:endpoint]).to eql("events")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.events.object_id)
    end
  end

  describe "#ingredients" do

    it "sets the options[:endpoint] to ingredients" do
      beer.ingredients
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:endpoint]).to eql("ingredients")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.ingredients.object_id)
    end
  end

  describe "#social_accounts" do

    it "sets the options[:endpoint] to socialaccounts" do
      beer.social_accounts
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:endpoint]).to eql("socialaccounts")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.social_accounts.object_id)
    end
  end

  describe "#variations" do

    it "sets the options[:endpoint] to variations" do
      beer.variations
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:endpoint]).to eql("variations")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.variations.object_id)
    end
  end

  describe "#params" do

    it "sets parameters" do
      beer.params(withSocialAccounts: "y", withGuilds: "n")
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:withSocialAccounts]).to eql("y")
      expect(beer_options[:withGuilds]).to eql("n")
    end

    it "merges data when called multiple times" do
      beer.params(test: "n")
      beer.params(test: "y")
      beer_options = beer.instance_variable_get(:"@options")
      expect(beer_options[:test]).to eql("y")
    end

    it "returns itself" do
      expect(beer.object_id).to eql(beer.params.object_id)
    end
  end

  describe "when making a request" do

    context "the id for a beer is not set" do

      it "raises a Tankard::Error::NoBeerId error" do
        expect { beer.each { |b| p b } }.to raise_error(Tankard::Error::NoBeerId)
      end
    end

    context "the id for a beer is set" do

      before do
        @request.stub(:get).with("beer/valid1", {}).and_return({ "data" => { "valid1_found" => "beer", "valid1_found_more" => "more_details" }})
      end

      it "uses the beer id in the uri" do
        expect(beer.id("valid1").collect { |x| x }).to eql([{"valid1_found" => "beer", "valid1_found_more" => "more_details" }])
      end
    end

    context "the endpoint is set" do

      before do
        @request.stub(:get).with("beer/valid1/breweries", {}).and_return({ "data" => ["valid1_found"]})
      end

      it "adds the endpoint to the request" do
        expect(beer.id("valid1").breweries.collect { |x| x }).to eql(["valid1_found"])
      end
    end

    context "additional options are set" do

      before do
        @beer_with_options = Tankard::Api::Beer.new(@request, test: "123", id: "valid1")
        @request.stub(:get).with("beer/valid1", Hashie::Mash.new(test: "123")).and_return({ "data" => ["valid1_found"]})
      end

      it "passes them to the request" do
        expect(@beer_with_options.collect { |x| x }).to eql(["valid1_found"])
      end
    end

    context "no data is returned" do

      before do
        @request.stub(:get).with("beer/valid1", {}).and_return({})
      end

      it "gracefully fails" do
        expect { beer.id("valid1").collect { |x| x} }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end
  end
end