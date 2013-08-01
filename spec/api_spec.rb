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
      PS::Util.should_receive(:convert_to_ps_object) { true }
      PS::Api::Json.any_instance.should_receive(:request) 
      subject.request("getstates")
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

  describe "#prepare_params" do
    subject { DummyClass }

    it "should Camel Case the param keys" do
      subject.prepare_params(test_customer()).should == test_customer_camel()
    end
  end
end