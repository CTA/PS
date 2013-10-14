require 'spec_helper'

describe "An instance of", PS::Response do
  before { connect() }
  context "where one class type is returend" do
    subject { PS::Response.new(test_ps_response_with_multiple_ps_objects()) }

    it "should check for success, and instantiate PsObject results" do
      response = subject
      response.instantiate_ps_objects.class.should == Array
      response.ps_object.each { |o| o.class.should_not == Hash }
    end

    it "raw should return an array" do
      subject.raw.class.should == Array
    end

  end

  context "Where more than one class type is returned" do
    subject { PS::Response.new(test_add_customer_and_make_cc_payment()) }

    it "should check for success, and prepare PsObject results" do
      PS::Response.any_instance.should_receive(:successful_request?) { true }
      subject.ps_object
    end
  end
end

