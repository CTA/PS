require 'spec_helper'

describe "An instance of", PS::Customer do
  before { connect() }

  describe "#create" do
    subject { PS::Customer }

    it "should create a new customer" do
      new_customer = FactoryGirl.build(:customer)
      new_customer.class.should == subject
    end
  end

  describe "#create_and_make_payment" do
    subject do
      PS::Customer.create_and_make_payment(
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

  describe "get_customer_and_default_accounts" do
    let(:customer_id) { PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id }

    before do
      #FIXME
      #TODO: create AchAccount and CreditCardAccount for customer_id
      #TODO: make reference instances with factories
      customer_account = PS::CustomerAccount.new({:customer_id => customer_id}) #need ps reference id
      ach_account = PS::AchAccount.new({:customer_id => customer_id, :is_checking_account => true, :routing_number => "000000000", :account_number => "4111111111111112", :bank_name => "Winnings Securities"})
      credit_card_account = PS::CreditCardAccount.new({:customer_id => customer_id, :account_number => "4111111111111111", :c_c_expiry => "12/#{Time.now.strftime("%Y")}", :c_c_ctype => 1})
      puts credit_card_account.attributes
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

  describe "relations" do
    subject { FactoryGirl.build(:customer) }

    it "should find the credit card account associated with the customer" do
      PS::CreditCardAccount.should_receive(:find).with(subject.ps_reference_id)
      subject.credit_card_account
    end
  end
end
