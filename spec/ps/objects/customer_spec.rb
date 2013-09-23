require 'spec_helper'

describe "An instance of", PS::Customer do
  before { connect() }

  describe "#create" do
    subject { PS::Customer }

    it "should create a new customer" do
      new_customer = subject.create(FactoryGirl.attributes_for(:customer))
      new_customer.class.should == subject
    end
  end

  describe "#create_and_make_cc_payment" do
    subject do
      PS::Customer.create_and_make_cc_payment(
        FactoryGirl.attributes_for(:customer),
        FactoryGirl.attributes_for(:credit_card_account),
        amount=1.00,
        "999"
      ) 
    end

    it "should create a customer, customerAccount, and Payment" do
      response = subject
      response[0].class.should == PS::Customer
      response[1].class.should == PS::CustomerAccount
      response[2].class.should == PS::Payment
    end
  end

  describe "#create_and_make_ach_payment" do
    let(:customer) { PS::Customer.create(FactoryGirl.attributes_for(:customer)) }
    subject do
      PS::Customer.create_and_make_ach_payment(
        customer,
        FactoryGirl.attributes_for(:ach_account),
        amount=1.00,
        "999"
      ) 
    end

    it "should create a customer, customerAccount, and Payment" do
      response = subject
      response[0].class.should == PS::Customer
      response[1].class.should == PS::CustomerAccount
      response[2].class.should == PS::Payment
    end
  end

  describe "get_customer_and_default_accounts" do
    let(:customer_id) { PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id }

    before do
      credit_card_account = PS::CreditCardAccount.create({:customer_id => customer_id, :account_number => "4111111111111111", :c_c_expiry => "12/#{Time.now.strftime("%Y")}", :c_c_type => 1})
      credit_card_account.make_default
    end

    subject { PS::Customer.get_customer_and_default_accounts(customer_id) }

    it "should get the customer and return customerAccount subclasses" do
      response = subject
      response[0].class.should == PS::Customer
      response[1].class.should == PS::CreditCardAccount
      response[2].class.should == PS::AchAccount
    end
  end

  describe "list methods" do
    subject { PS::Customer }

    describe "#find" do
      let(:customer_id) { PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id }
      context "given an id" do
        it "should find a customer" do
          customer = subject.find(customer_id)
          customer.class.should == subject
        end
      end

      context "given a hash of customer attributes" do
        let(:customer_attributes) { FactoryGirl.attributes_for(:customer) }
        it "should find a customer"
      end

      it "should search for a customer based off of search criteria provided."
      it "should list all customers"
    end
  end

  describe "#destroy" do
    context "given existing customer object" do
      subject { PS::Customer.create(FactoryGirl.attributes_for(:customer)) }

      it "should delete a customer object that exists" do
        subject.destroy.should == true
      end
    end

    context "given a customer object that doesn't exist" do
      subject { FactoryGirl.build(:customer).destroy }

      it "should return false" do
        subject.should eq(false) 
      end
    end
  end

  describe "#save" do
    context "with valid input" do
      subject { PS::Customer.new(FactoryGirl.attributes_for(:customer)) }

      it "should save a customer" do
        subject.save().should == true
        subject.ps_reference_id.should_not be_nil
      end
    end

    context "with invalid input" do
      subject { PS::Customer.new({ :farw => 'tetet' }) }

      it "should return false" do
        subject.save().should == false
      end
    end
  end

  describe "relations" do
    let(:customer_id) { PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id }
    subject { PS::Customer.find(customer_id) }

    it "should find the credit card account associated with the customer" do
      PS::CreditCardAccount.should_receive(:default_for_customer_id).with(customer_id)
      subject.default_credit_card_account
    end
    
    it "should set the default customer account" do
      PS::CustomerAccount.should_receive(:find) { FactoryGirl.build(:customer_account) }
      PS::CustomerAccount.any_instance.should_receive(:make_default)
      subject.set_default_customer_account(5)
    end

    it "should get the default customer account" do
      PS::CustomerAccount.should_receive(:default).with(customer_id)
      subject.default_customer_account
    end
  end
end
