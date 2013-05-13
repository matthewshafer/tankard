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

  describe "#each" do

    it "should call raise_if_required_options_not_set" do
      search.stub(:find_on_single_or_all_pages).and_return(nil)
      search.should_receive(:raise_if_required_options_not_set)
      search.each
    end

    it "calls the super object with the block" do
      block = -> x { x }
      search.stub(:raise_if_required_options_not_set).and_return(nil)
      search.should_receive(:find_on_single_or_all_pages)
      search.each(&block)
    end
  end

  describe "private methods" do

    describe "#raise_if_required_options_not_set" do

      context "the endpoint is not set" do

        it "raises Tankard::Error::NoSearchQuery when the query is not set" do
          expect { search.send(:raise_if_required_options_not_set) }.to raise_error(Tankard::Error::NoSearchQuery)
        end

        it "does not raise Tankard::Error::NoSearchQuery when the query is set" do
          search.instance_variable_get(:"@options")[:q] = "findme"
          expect { search.send(:raise_if_required_options_not_set) }.not_to raise_error(Tankard::Error::NoSearchQuery)
        end
      end

      context "the endpoint is set to upc" do

        before do
          search.instance_variable_get(:"@options")[:endpoint] = "upc"
        end

        it "raises Tankard::Error::MissingParameter when code is not set" do
          expect { search.send(:raise_if_required_options_not_set) }.to raise_error(Tankard::Error::MissingParameter, "missing parameter: code")
        end

        it "does not raise Tankard::Error::MissingParameter when code is set" do
          search.instance_variable_get(:"@options")[:code] = "1234"
          expect { search.send(:raise_if_required_options_not_set) }.not_to raise_error(Tankard::Error::MissingParameter)
        end
      end

      context "the endpoint is set to geo/point" do

        before do
          search.instance_variable_get(:"@options")[:endpoint] = "geo/point"
        end

        it "raises Tankard::Error::MissingParameter when latitude is not set" do
          search.instance_variable_get(:"@options")[:lng] = 123
          expect { search.send(:raise_if_required_options_not_set) }.to raise_error(Tankard::Error::MissingParameter, "missing Parameters: lat, lng")
        end

        it "raises Tankard::Error::MissingParameter when longitude is not set" do
          search.instance_variable_get(:"@options")[:lat] = 123
          expect { search.send(:raise_if_required_options_not_set) }.to raise_error(Tankard::Error::MissingParameter, "missing Parameters: lat, lng")
        end

        it "raises Tankard::Error::MissingParameter when latitude and longitude are not set" do
          expect { search.send(:raise_if_required_options_not_set) }.to raise_error(Tankard::Error::MissingParameter, "missing Parameters: lat, lng")
        end

        it "does not raise Tankard::Error::MissingParameter when latitude and longitude are set" do
          search.instance_variable_get(:"@options")[:lat] = 123
          search.instance_variable_get(:"@options")[:lng] = 123
          expect { search.send(:raise_if_required_options_not_set) }.not_to raise_error(Tankard::Error::MissingParameter)
        end
      end
    end

    describe "#http_request_uri" do

      context "no endpoint is set" do

        it "returns search" do
          expect(search.send(:http_request_uri)).to eql("search")
        end
      end

      context "an endpoint is set" do

        before do
          search.instance_variable_get(:"@options")[:endpoint] = "upc"
        end

        it "adds the endpoint to the uri" do
          expect(search.send(:http_request_uri)).to eql("search/upc")
        end

        it "removes the endpoint from options" do
          search.send(:http_request_uri)
          expect(search.instance_variable_get(:"@options")[:endpoint]).to eql(nil)
        end
      end
    end

    describe "#http_client" do

      it "returns the request variable that is passed when the class is created" do
        expect(search.send(:http_client).object_id).to eql(@request.object_id)
      end
    end

    describe "#http_request_parameters" do

      it "returns the options for the request" do
        expect(search.send(:http_request_parameters).object_id).to eql(search.instance_variable_get(:"@options").object_id)
      end
    end
  end
end