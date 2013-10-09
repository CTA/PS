require 'spec_helper'

describe "An instance of", PS::Response do
  before { connect() }
  context "where one class type is returend" do
    subject { PS::Response.new(test_ps_response_with_multiple_ps_objects()) }

    it "should check for success, and instantiate PsObject results" do
      response = subject
      response.instantiate_ps_objects.class.should == Array
      response.each { |o| o.class.should_not == Hash }
    end

    it "raw should return an array" do
      subject.raw.class.should == Array
    end

    context "array methods" do
      it "should take args" do
        subject.fetch(0).should == subject.ps_object[0]
      end
      
      it "should take blocks" do
        map_block = Proc.new { |obj| obj }
        subject.ps_object.should_receive(:map).with(&map_block)
        subject.map &map_block
      end

      it "should look like an array" do
        subject.to_s.should == subject.ps_object
      end

      it "should throw error if undefined method" do
        expect { subject.method_that_does_not_exist }.to raise_error(NoMethodError)
      end
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

