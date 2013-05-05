require 'spec_helper'

describe Tankard::Api::Beers do
  let(:beers) { Tankard::Api::Beers.new(@request) }

  before do
    @request = mock("request")
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

  describe "when making a request" do

    context "and a page is set" do

      it "only queries a single page" do
        beers.should_receive(:find_on_single_page)
        beers.page(1).each { |x| x }
      end
    end

    context "and a page is not set" do

      it "queries multiple pages" do
        beers.should_receive(:find_on_all_pages)
        beers.each { |x| x }
      end
    end

    context "and additional options are set without a page" do

      before do
        @beers_with_options = Tankard::Api::Beers.new(@request, test: "123")
        @request.stub(:get).with("beers", Hashie::Mash.new(test: "123", p: 1)).and_return({ "data" => ["beers"]})
      end

      it "passes them to the request" do
        expect(@beers_with_options.collect { |x| x }).to eql(["beers"])
      end
    end

    context "and additional options are set with a page" do

      before do
        @beers_with_options = Tankard::Api::Beers.new(@request, test: "123", p: 2)
        @request.stub(:get).with("beers", Hashie::Mash.new(test: "123", p: 2)).and_return({ "data" => ["beers"]})
      end

      it "passes them to the request" do
        expect(@beers_with_options.collect { |x| x }).to eql(["beers"])
      end
    end

    context "and no data is returned on a single page request" do

      before do
        @beers = Tankard::Api::Beers.new(@request, p: 1)
        @request.stub(:get).with("beers", Hashie::Mash.new(p: 1)).and_return({})
      end

      it "raises a Tankard::Error::InvalidResponse error" do
        expect { @beers.collect { |x| x} }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end

    context "and no data is returned on a page in a multi page request" do

      before do
        @beers = Tankard::Api::Beers.new(@request)
        @request.stub(:get).with("beers", Hashie::Mash.new(p: 1)).and_return({"numberOfPages" => 2, "data" => ["test1", "test2"]})
        @request.stub(:get).with("beers", Hashie::Mash.new(p: 2)).and_return({})
      end

      it "raises a Tankard::Error::InvalidResponse error" do
        expect { @beers.collect { |x| x} }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end

    context "and a page is not specified" do

      before do
        @beers = Tankard::Api::Beers.new(@request)
        @request.stub(:get).with("beers", Hashie::Mash.new(p: 1)).and_return({"numberOfPages" => 2, "data" => ["test1", "test2"]})
        @request.stub(:get).with("beers", Hashie::Mash.new(p: 2)).and_return({"numberOfPages" => 2, "data" => ["test3", "test4"]})
      end

      it "runs through all of the pages returned by brewerydb" do
        expect(@beers.collect { |x| x}).to eql(["test1", "test2", "test3", "test4"])
      end
    end
  end
end