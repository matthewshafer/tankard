require 'spec_helper'

describe Tankard::Api::Styles do

  let(:styles) { Tankard::Api::Styles.new(@request) }

  before do
    @request = mock("request")
  end

  describe "when making a request" do

    context "and no data is returned" do

      it "raises a Tankard::Error::InvalidResponse error" do
        @request.stub(:get).with("styles", nil).and_return({})
        expect { styles.collect { |x| x} }.to raise_error(Tankard::Error::InvalidResponse)
      end
    end

    it "returns the data portion of the request" do
      @request.stub(:get).with("styles", nil).and_return({"data" => ["test1", "test2"]})
      expect(styles.collect { |x| x}).to eql(["test1", "test2"])
    end
  end
end