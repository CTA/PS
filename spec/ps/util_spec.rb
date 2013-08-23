require 'spec_helper'

class DummyClass
  extend PS::Util
end

describe PS::Util do
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
