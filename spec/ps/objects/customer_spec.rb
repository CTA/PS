require 'spec_helper'

describe "An instance of", PS::Customer do
  before { connect() }

  describe "#create" do
    subject { PS::Customer }

    it "should create a new customer" do
      new_customer = subject.create(test_customer())
      new_customer.class.should == subject
    end
  end

  describe "list methods" do
    subject { PS::Customer }

    describe "#find" do
      let(:customer_id) { subject.create(test_customer()).attributes[:ps_reference_id] }
      context "given an id" do
        it "should find a customer" do
          customer = subject.find(customer_id)
          customer.class.should == subject
        end
      end

      context "given a hash of customer attributes" do
        it "should find a customer"
      end

      it "should search for a customer based off of search criteria provided."
      it "should list all customers"
    end
  end

  describe "#destroy" do
    context "given existing customer object" do
      subject { PS::Customer.create(test_customer()) }

      it "should delete a customer object that exists" do
        subject.destroy.should == true
      end
    end

    context "given a customer object that doesn't exist" do
      subject { PS::Customer.new(test_customer()) }

      it "should return false" do
        subject.destroy.should == false
      end
    end
  end

  describe "relations" do
    subject { PS::Customer.create(test_customer()) }

    it "should find the credit card account associated with the customer" do
      PS::CreditCardAccount.should_receive(:find).with(subject.ps_reference_id)
      subject.credit_card_account
    end
  end
end
