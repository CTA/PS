require 'spec_helper'

class DummyClass
  extend PS::Api
end
describe "An instance of", PS::Api do
  context "given a JSON format" do
    subject { DummyClass }
    before { subject.connect("json") }

    it "should initialize the JSON api class" do
      $api.class.should == PS::Api::Json
    end

    it "should returned the required attributes" do
      subject.required_attributes().class.should == Array
    end

    it "should make an api request" do
      PS::Response.stub(:ps_object) { false }
      PS::Api::Json.any_instance.should_receive(:request) { PS::Response }
      subject.request("getstates")
    end
  end

  context "Given an unsupported format" do
    subject { DummyClass }

    it "should raise a connection error" do
      expect {
        subject.connect("invalid_format")
      }.to raise_error(PS::ConnectionError, "invalid_format is not a supported format")
    end
  end

  describe "#host" do
    let(:ps_api) { DummyClass }

    subject { ps_api.host() }
    
    it "should return the dev url" do
      ps_api.should_receive(:env) { "development" }
      subject.should == "https://sandbox-api.paysimple.com/3.00/paysimpleapi"
    end

    it "should return the production  url" do
      ps_api.should_receive(:env).exactly(2) { "production" }
      subject.should == "https://api.paysimple.com/3.00/paysimpleapi"
    end
  end

end
