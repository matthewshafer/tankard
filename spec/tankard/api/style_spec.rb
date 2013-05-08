require 'spec_helper'

describe Tankard::Api::Style do
  let(:style) { Tankard::Api::Style.new(@request) }

  before do
    @request = mock("request")
  end

  describe "#find" do

    before do
      @request.stub(:get).with("style/1", {}).and_return({ "data" => "valid1_found"})
      @request.stub(:get).with("style/2", {}).and_return({ "data" => "valid2_found"})
      @request.stub(:get).with("style/3", {}).and_raise(Tankard::Error::HttpError)
      @request.stub(:get).with("style/4", {}).and_raise(Tankard::Error::HttpError)
    end

    it_should_behave_like "the find method" do
      let(:context) { style }
      let(:valid_items) { [1, 2] }
      let(:valid_responses) { ["valid1_found", "valid2_found"] }
      let(:invalid_items) { [3, 4] }
      let(:valid_invalid_items) { valid_items + invalid_items }
    end
  end

  describe "#id" do

    it "sets the options[:id] fo the style id passed in" do
      style.id(1)
      style_options = style.instance_variable_get(:"@options")
      expect(style_options[:id]).to eql(1)
    end

    it "returns itself" do
      expect(style.object_id).to eql(style.id(1).object_id)
    end
  end

  describe "when making a request" do

    context "and the id for a style is not set" do

      it "raises a Tankard::Error::NoStyleId" do
        expect { style.each { |s| p s } }.to raise_error(Tankard::Error::NoStyleId)
      end
    end

    context "and the id for a style is set" do

      before do
        @request.stub(:get).with("style/1", {}).and_return({ "data" => ["style_valid"] })
      end

      it "uses the style id in the uri" do
        expect(style.id(1).collect { |x| x}).to eql(["style_valid"])
      end
    end

    context "and no data is returned" do

      before do
        @request.stub(:get).with("style/1", {}).and_return({})
      end

      it "raises a Tankard::Error::InvalidResponse" do
        expect { style.id(1).collect { |x| x } }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end
  end
end