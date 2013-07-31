require 'spec_helper'

describe "An instance of", PS::Customer do
  before { connect() }

  describe "#create" do
    subject { PS::Customer }

    it "should create a new customer" do
      subject.create(test_customer())
    end
  end

  describe "list methods" do
    subject { PS::Customer }

    describe "#find" do
      let(:customer_id) { subject.create(test_customer()).PsReferenceId }
      context "given an id" do
        it "should find a customer" do
          customer = subject.find(customer_id)
          customer.class.should == subject
        end
      end

      context "given a hash of customer attributes" do
        it "should find a customer" do
          #customer = subject.find(test_customer())
          #customer.PsReferenceId.should == customer_id
        end
      end

      it "should search for a customer based off of search criteria provided."
      it "should list all customers"
    end

    describe "#all" do
      it "should list all customers" do
        subject.all()
      end
    end
  end

  
end
