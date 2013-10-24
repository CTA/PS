require 'spec_helper'

describe "An instance of", PS::RecurringPayment do
  before { connect() }
  let(:customer_id) do
    PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id 
  end
  let(:customer_account_id) do
    PS::CreditCardAccount.create(
      FactoryGirl.attributes_for(:credit_card_account, :customer_id => customer_id )
    ).ps_reference_id 
  end
  
  describe "#create" do
    subject { PS::RecurringPayment }
    it "should create a new recurring payment" do
      new_payment = subject.create(test_recurring_payment())
      new_payment.class.should == subject
    end
  end

  context "given a recurring payment" do
    subject do
      PS::RecurringPayment.create(
        FactoryGirl.attributes_for(:recurring_payment, 
          { 
            :customer_id => customer_id,
            :customer_account_id => customer_account_id
          }
        ) 
      )
    end

    describe "#update" do
      it "should be able to set an instance variable to something else and update" do
        p subject.attributes
        subject.has_end_date = true
        subject.end_date = Time.now+(86400*365)
        subject.update
      end
    end

    describe "#suspend" do
      it "should suspend the schedule" do
        subject.suspend
      end
    end

    describe "#resume" do
      it "should resume the schedule" do
        subject.resume
      end
    end
  end

  describe ".list" do
  end

end
