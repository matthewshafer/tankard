require 'spec_helper'

describe Tankard::Api::Beers do
  let(:beers) { Tankard::Api::Beers.new(@request) }

  before do
    @request = double("request")
  end

  describe "#name" do

    it "sets the options[:name] of a beer" do
      beers.name("stone")
      beers_options = beers.instance_variable_get(:"@options")
      expect(beers_options[:name]).to eql("stone")
    end

    it "returns self" do
      expect(beers.object_id).to eql(beers.name("stone").object_id)
    end
  end

  describe "#page" do

    it "sets the options[:p] for the page number" do
      beers.page(1)
      beers_options = beers.instance_variable_get(:"@options")
      expect(beers_options[:p]).to eql(1)
    end

    it "returns self" do
      expect(beers.object_id).to eql(beers.page(1).object_id)
    end
  end

  describe "#params" do

    it "sets parameters" do
      beers.params(withSocialAccounts: "y", withGuilds: "n")
      beers_options = beers.instance_variable_get(:"@options")
      expect(beers_options[:withSocialAccounts]).to eql("y")
      expect(beers_options[:withGuilds]).to eql("n")
    end

    it "merges params when called multiple times" do
      beers.params(test: "n")
      beers.params(test: "y")
      beers_options = beers.instance_variable_get(:"@options")
      expect(beers_options[:test]).to eql("y")
    end

    it "returns itself" do
      expect(beers.object_id).to eql(beers.params.object_id)
    end
  end

  describe "private methods" do

    describe "#http_request_uri" do

      it "returns the string beers" do
        expect(beers.send(:http_request_uri)).to eql("beers")
      end
    end

    describe "#http_client" do

      it "returns the request variable that is passed in when the class is initialized" do
        expect(beers.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe "#http_request_parameters" do

      it "returns the options for the request" do
        expect(beers.send(:http_request_parameters).object_id).to eql(beers.instance_variable_get(:"@options").object_id)
      end
    end
  end
end