require 'spec_helper'

describe "An instance of", PS::RecurringPayment do
  before { connect() }
  
  describe "#create" do
    subject { PS::RecurringPayment }
    it "should create a new recurring payment" do
      new_payment = subject.create(test_recurring_payment())
      new_payment.class.should == subject
    end
  end

  describe "#save" do
    subject { PS::RecurringPayment }
    it "should save the attributes of a new recurring payment" do

      subject.new(test_recurring_payment()).save.class.should == subject
    end
  end

  describe "#edit" do
    subject { PS::RecurringPayment.create(test_recurring_payment()) }
    context "given an instantiation of a", PS::RecurringPayment, " object" do
      it "should be able to set an instance variable to something else and update" do
        subject.has_end_date = true
        subject.end_date = Time.now+(86400*365)
        subject.edit
      end
    end
  end

  describe "#suspend" do
  end

  describe "#resume" do
  end

  describe ".list" do
  end

end
