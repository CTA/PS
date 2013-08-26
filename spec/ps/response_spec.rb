require 'spec_helper'

describe "An instance of", PS::Response do
  before { connect() }
  context "not requesting addcustomerandmakeccpayment" do
    context "subject.ps_object's length is 1" do
      subject { PS::Response.new(test_ps_response_with_single_ps_object()) }

      it "should check for success, and prepare PsObject results" do
        subject.ps_object.class.should == PS::Customer
      end

      it "should parse the date" do
        subject.ps_object.last_modified.instance_of?(Time).should == true
      end
    end

    context "subject.ps_object's length is greater than 1" do
      subject { PS::Response.new(test_ps_response_with_multiple_ps_objects()) }
      it "should check for success, and prepare PsObject results" do
        ps_object = subject.ps_object
        ps_object.class.should == Array
        ps_object.each { |o| o.class.should == PS::Customer } 
      end
    end
  end

  context "requesting addcustomerandmakeccpayment" do
    subject { PS::Response.new(test_add_customer_and_make_cc_payment()) }

    it "should check for success, and prepare PsObject results" do
      PS::Response.any_instance.should_receive(:successful?) { true }
      subject
    end
  end
end
