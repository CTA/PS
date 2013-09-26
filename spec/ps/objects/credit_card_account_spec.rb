require 'spec_helper'

describe PS::CreditCardAccount do
  before { connect() }
  let(:customer_id) do
    PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id 
  end

  describe "class methods" do
    describe "#create" do
      subject do
        PS::CreditCardAccount.create(
          FactoryGirl.attributes_for(:credit_card_account, :customer_id => customer_id)
        )
      end

      it "should create a credit card account" do
        subject.class.should == PS::CreditCardAccount
      end
    end

    describe "#default_for_customer_id" do
      let(:credit_card) { FactoryGirl.create(:credit_card_account, :customer_id => customer_id) }
      before { credit_card.make_default }
      subject { PS::CreditCardAccount.default_for_customer_id(customer_id) }

      it "should get the default credit card for a customer" do
        subject.ps_reference_id.should == credit_card.ps_reference_id
      end
    end
  end

  describe "instance methods" do
    let(:credit_card) { FactoryGirl.create(:credit_card_account, :customer_id => customer_id) }

    describe ".update" do
      before do 
        credit_card.c_c_expiry = "11/2016"
      end
      subject { credit_card.update }

      it "should update the credit card's attributes" do
        subject
      end
    end


    describe ".delete" do
      subject { credit_card.delete() }

      it "should delete the credit_card" do
        subject
      end
    end
  end
end
