require 'spec_helper'

describe "An instance of", PS::RecurringPayment do
  before { connect() }
  let(:customer_id) do
    FactoryGirl.create(:customer).ps_reference_id
  end
  let(:customer_account_id) do
    PS::CreditCardAccount.create(
      FactoryGirl.attributes_for(:credit_card_account, :customer_id => customer_id )
    ).ps_reference_id 
  end
  
  describe "#create" do
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

    it "should create a new recurring payment" do
      new_payment = subject
      new_payment.class.should == PS::RecurringPayment
    end
  end

  context "bad save" do
    subject do
      PS::RecurringPayment.new(
        FactoryGirl.attributes_for(:recurring_payment, {:start_date => "ratesdlcd" })
      ).save()
    end

    it "should catch the exception and return false" do
      subject.should == false
    end
  end

  describe "#destroy" do
    let(:schedule) {
      PS::RecurringPayment.create(
        FactoryGirl.attributes_for(:recurring_payment, 
          { 
            :customer_id => customer_id,
            :customer_account_id => customer_account_id,
            :start_date => Time.now+(36400*3)
          }
        ) 
      )
    }

    subject { schedule.destroy }

    it "should delete a schedule" do
      subject
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
    let(:start_date) { Time.now - (36400*5) }
    let(:end_date) { Time.now + (36400*5) }
    let(:customer_id) { FactoryGirl.create(:customer).ps_reference_id }
    let(:account_id) { FactoryGirl.create(:credit_card_account, { :customer_id => customer_id }).ps_reference_id }


    subject { PS::RecurringPayment.list(start_date, end_date, customer_id) }

    before do
      2.times do
        PS::RecurringPayment.create(
          FactoryGirl.attributes_for(:recurring_payment, 
            {
              :customer_id => customer_id,
              :customer_account_id => account_id
            }
          )
        )
      end
    end

    it "should return all schedules between the start_date and end_date for a given customer_id" do
      schedules = subject
      schedules.length.should == 2
    end
  end

  describe ".find" do
    let(:customer_id) { FactoryGirl.create(:customer).ps_reference_id }
    let(:account_id) { FactoryGirl.create(:credit_card_account, { :customer_id => customer_id }).ps_reference_id }
    let(:schedule_id) do
        PS::RecurringPayment.create(
          FactoryGirl.attributes_for(:recurring_payment, 
            {
              :customer_id => customer_id,
              :customer_account_id => account_id
            }
          )
        ).ps_reference_id
    end

    subject { PS::RecurringPayment.find(schedule_id) }

    it "should return the schedule base off of the schedule id" do
      subject.ps_reference_id.should == schedule_id
    end
  end
end
