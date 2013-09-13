require 'spec_helper'

describe "An instance of", PS::Payment do
  
  describe "#find" do
    subject { PS::Payment.new(FactoryGirl.attributes_for(:payment)) }
    it "should find a customer given a customer_id" do
      puts subject.inspect 
    end

    it "should find a customer given criteria to search with"
  end
  
  describe "#cancel_payment" do
    it "should cancel the given payment."
  end

  describe "#reverse_payment" do
    it "should reverse the given payment"
  end
  
  describe ".cancel_payment" do
    it "should cancel a payment given a payment id."
  end

  describe ".reverse_payment" do
    it "should reverse a payment given a payment id."
  end
  
  describe ".make" do
    context "given a customer_id and amount" do
      it "should make a payment."
    end
  end

end
