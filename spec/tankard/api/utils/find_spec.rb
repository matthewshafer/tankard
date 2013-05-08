require 'spec_helper'

describe Tankard::Api::Utils::Find do

  let(:find) { Class.new { include Tankard::Api::Utils::Find }.new }

  describe "#route" do

    it "raises NoMethodError" do
      expect { find.send(:route) }.to raise_error(NoMethodError, "Must implement and return the base route")
    end
  end

  describe "#http_client" do

    it "raises NoMethodError" do
      expect { find.send(:http_client) }.to raise_error(NoMethodError, "Must return the http object to make requests with")
    end
  end

  describe "#http_request_parameters" do

    it "raises NoMethodError" do
      expect { find.send(:http_request_parameters) }.to raise_error(NoMethodError, "Must return a hash like structure with request parameters")
    end
  end
end