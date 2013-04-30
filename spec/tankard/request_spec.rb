require 'spec_helper'

describe Tankard::Request do
  
  let(:request) { Tankard::Request.new("abc123") }

  describe "#get" do

    context "request status is not 200" do

      it "raises a Tankard::Error::HttpError" do
        stub_get("test?key=abc123").to_return(status: [404, "Not Found"])
        expect { request.get("test") }.to raise_error(Tankard::Error::HttpError)
      end
    end

    context "request status is 200" do

      it "does not raise a Tankard::Error::HttpError" do
        stub_get("test?key=abc123").to_return(status: 200)
        expect { request.get("test") }.not_to raise_error(Tankard::Error::HttpError)
      end
    end

    context "valid json response" do

      it "returns the json decoded body" do
        stub_get("test?key=abc123").to_return(body: '{ "beer_name": "Smoked Porter" }')
        expect(request.get("test")["beer_name"]).to eql("Smoked Porter")
      end
    end

    context "invalid json response" do

      it "raises an error" do
        stub_get("test?key=abc123").to_return(body: '{')
        expect { request.get("test") }.to raise_error(Tankard::Error::LoadError)
      end
    end
  end
end