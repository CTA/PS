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

  context "given any format" do
    subject { DummyClass }

    context "with a request that has hash values" do
      let(:test_request) { { :customer => test_customer } }
      it "should CamelCase the request keys" do
        subject.camel_case_request(test_request)[:customer].should == test_customer_camel()
      end
    end

    context "with a response that has hash values" do
      it "should snake_case the object keys" do
        subject.snake_case_response(test_response()).should == test_response_snake()
      end
    end
  end
end
