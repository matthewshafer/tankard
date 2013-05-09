require 'spec_helper'

describe Tankard::Api::Search do

  let(:search) { Tankard::Api::Search.new(@request) }

  before do
    @request = mock("request")
  end

  describe "#query" do

    it "sets options[:q] with the query the user wants to run" do
      search.query("test")
      search_options = search.instance_variable_get(:"@options")
      expect(search_options[:q]).to eql("test")
    end

    it "returns itself" do
      expect(search.object_id).to eql(search.query("test").object_id)
    end

  end

  describe "#params" do

    it "sets parameters" do
      search.params(withSocialAccounts: "y", withGuilds: "n")
      search_options = search.instance_variable_get(:"@options")
      expect(search_options[:withSocialAccounts]).to eql("y")
      expect(search_options[:withGuilds]).to eql("n")
    end

    it "merges params when called multiple times" do
      search.params(test: "n")
      search.params(test: "y")
      search_options = search.instance_variable_get(:"@options")
      expect(search_options[:test]).to eql("y")
    end

    it "returns itself" do
      expect(search.object_id).to eql(search.params.object_id)
    end
  end

  describe "#type" do

    it "sets options[:type] with the type to search for" do
      search.type("beer")
      search_options = search.instance_variable_get(:"@options")
      expect(search_options[:type]).to eql("beer")
    end

    it "returns itself" do
      expect(search.object_id).to eql (search.type("test").object_id)
    end
  end

  describe "#page" do

    it "sets options[:p] with the page number to load" do
      search.page(1)
      search_options = search.instance_variable_get(:"@options")
      expect(search_options[:p]).to eql(1)
    end

    it "returns itself" do
      expect(search.object_id).to eql(search.page(1).object_id)
    end
  end

  describe "#upc" do

    before do
      search.upc("123")
      @search_options = search.instance_variable_get(:"@options")
    end

    it "sets options[:endpoint] with the search endpoint to use" do
      expect(@search_options[:endpoint]).to eql("upc")
    end

    it "sets options[:code] with the upc code" do
      expect(@search_options[:code]).to eql("123")
    end

    it "returns itself" do
      expect(search.object_id).to eql(search.upc("123").object_id)
    end
  end

  describe "#geo_point" do

    before do
      search.geo_point(1.23, 4.56)
      @search_options = search.instance_variable_get(:"@options")
    end

    it "sets options[:endpoint] with the correct search endpoint to use" do
      expect(@search_options[:endpoint]).to eql("geo/point")
    end

    it "sets options[:lat] with the latitude" do
      expect(@search_options[:lat]).to eql(1.23)
    end

    it "sets options[:lng] with the longitude" do
      expect(@search_options[:lng]).to eql(4.56)
    end

    it "returns itself" do
      expect(search.object_id).to eql(search.geo_point(1.3, 4.5).object_id)
    end
  end

  describe "when making a request" do

    context "and a page is set" do

      it "only queries a single page" do
        search.should_receive(:find_on_single_page)
        search.query("test").page(1).each { |x| x }
      end
    end

    context "and a page is not set" do

      it "queries multiple pages" do
        search.should_receive(:find_on_all_pages)
        search.query("test").each { |x| x }
      end
    end

    context "and the search query is not set" do

      it "raises Tankard::Error::NoSearchQuery" do
        expect { search.each { |s| p s } }.to raise_error(Tankard::Error::NoSearchQuery)
      end
    end

    context "and the search query is set" do

      before do
        @request.stub(:get).with("search", Hashie::Mash.new(p: 1, q: "test")).and_return("data" => ["search_result"])
      end

      it "uses the query in the request parameters" do
        expect(search.query("test").collect { |x| x }).to eql(["search_result"])
      end
    end

    context "the endpoint is set" do

      before do
        @request.stub(:get).with("search/upc", Hashie::Mash.new(code: "123", p: 1)).and_return({ "data" => ["search_result"] })
      end

      it "adds the endpoint to the request" do
        expect(search.upc("123").collect { |x| x }).to eql(["search_result"])
      end
    end

    context "the upc endpoint is set without the code parameter" do

      it "raises Tankard::Error::MissingParameter" do
        expect { search.params(endpoint: "upc").collect { |x| x } }. to raise_error(Tankard::Error::MissingParameter)
      end
    end

    context "the geo/point endpoint isset without lat or lng parameters" do

      it "raises Tankard::Error::MissingParameter when lat is set but lng isnt" do
        expect { search.params(endpoint: "geo/point", lat: 123).collect { |x| x } }.to raise_error(Tankard::Error::MissingParameter)
      end

      it "raises Tankard::Error::MissingParameter when lng is set but lat isnt" do
        expect { search.params(endpoint: "geo/point", lng: 2).collect { |x| x } }.to raise_error(Tankard::Error::MissingParameter)
      end

      it "raises Tankard::Error::MissingParameter when lat and lng are not set" do
        expect { search.params(endpoint: "geo/point").collect { |x| x } }.to raise_error(Tankard::Error::MissingParameter)
      end
    end

    context "additional options are set" do

      before do
        @search_with_options = Tankard::Api::Search.new(@request, test: "123", p: 1, q: "search")
        @request.stub(:get).with("search", Hashie::Mash.new(test: "123", p: 1, q: "search")).and_return({ "data" => ["searched"] })
      end

      it "passes them to the request" do
        expect(@search_with_options.collect { |x| x }).to eql(["searched"])
      end
    end

    context "and no data is returned on a single page request" do

      before do
        @request.stub(:get).with("search", Hashie::Mash.new(q: "test", p: 1)).and_return({})
      end

      it "raises Tankard::Error::InvalidResponse" do
        expect { search.query("test").page(1).collect { |x| x } }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end

    context "and no data is returned on a multi page request" do
      before do
        @search = Tankard::Api::Search.new(@request)
        @request.stub(:get).with("search", Hashie::Mash.new(q: "test", p: 1)).and_return({ "numberOfPages" => 2, "data" => ["test1", "test2"] })
        @request.stub(:get).with("search", Hashie::Mash.new(q: "test", p: 2)).and_return({})
      end

      it "raises Tankard::Error::InvalidResponse" do
        expect { @search.query("test").collect { |x| x } }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end
  end
end