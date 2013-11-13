require 'spec_helper'

describe "An instance of", PS::Payment do
  before { connect() }
  let(:customer_id) { PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id }
  let(:customer_account_id) do
    PS::CreditCardAccount.create(
      FactoryGirl.attributes_for(:credit_card_account, :customer_id => customer_id )
    ).ps_reference_id 
  end
  let(:amount) { 5 }
  
  describe "#list" do
    let(:payment_id) do
      PS::Payment.make(customer_id, amount, customer_account_id)
    end
    subject { PS::Payment.list(customer_id) }

    it "should list the payments for a customer given a their id" do
      subject
    end

    #need pages to iterate through...
    it "should find a customer given criteria to search with" 
  end
  
  describe "manage payment" do
    context "with instance" do
      subject do
        PS::Payment.make(customer_id, amount, customer_account_id)
      end

      context "#cancel_payment" do
        it "should cancel the given payment." do
          payment = subject
          payment.cancel
          payment.status.should == PaymentStatus::VOIDED 
        end
      end

      context "#reverse_payment" do
        it "should reverse the given payment" do
          #cannot test
        end
      end
    end
    
    context "with id" do
      let(:payment_id) do
        PS::Payment.make(customer_id, amount, customer_account_id).ps_reference_id
      end
      subject { PS::Payment }

      context ".cancel_by_id" do
        it "should cancel a payment given a payment id." do
          subject.cancel_by_id(payment_id).should == true
        end
      end

      context ".reverse_by_id" do
        it "should reverse a payment given a payment id." do
          #cant be tested
        end
      end
    end
  end
  
  describe ".make" do
    subject do
      PS::Payment.make(customer_id, amount, customer_account_id)
    end
    context "given a customer_id and amount" do
      it "should make a payment." do
        payment = subject
        payment.ps_reference_id.should_not be_nil
        payment.status.should == PaymentStatus::AUTHORIZED
      end
    end
  end

  describe "&update_by_find" do
    before do
      8.times do
        PS::Payment.make(customer_id, amount, customer_account_id)
      end
    end
    subject do
      PS::Payment.make(customer_id, amount, customer_account_id)
    end

    it "should iterate through the payments and update the correct attrs" do
      payment = subject
      payment.status.should == PaymentStatus::AUTHORIZED
      payment.cancel
      payment.status.should == PaymentStatus::VOIDED
    end
  end
end
