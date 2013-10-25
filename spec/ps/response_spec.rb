require 'spec_helper'

describe "An instance of", PS::Response do
  before { connect() }
  context "where more than one ps_object is returned" do
    context "of the same subtype" do
      subject { PS::Response.new(test_ps_response_with_multiple_ps_objects()) }

      it "should check for success" do
        PS::Response.any_instance.should_receive(:successful_request?) 
        subject
      end

      it "raw should return an array" do
        subject.ps_object.class.should == Array
      end

    end

    context "of different subtypes" do
      subject { PS::Response.new(test_add_customer_and_make_cc_payment()) }

      it "should check for success, and prepare PsObject results" do
        PS::Response.any_instance.should_receive(:successful_request?) { true }
        subject.ps_object
      end
    end
  end

  context "where one ps_object is returned" do
    subject { PS::Response.new(test_ps_response_with_single_ps_object()) }

    it "then ps_object should only contain one object" do
      response = subject
      response.ps_object.class.should == Hash
    end
  end
end

