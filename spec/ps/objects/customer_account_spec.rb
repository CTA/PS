require 'spec_helper'

describe "An instance of", PS::CustomerAccount do
  before { connect() }
  let(:customer_id) { FactoryGirl.create(:customer).ps_reference_id }

  describe ".make_default" do
    let(:customer_id) { FactoryGirl.create(:customer).ps_reference_id }
    subject do
      FactoryGirl.create(:credit_card_account, { :customer_id => customer_id }) 
    end

    it "should make it default" do
      subject.make_default
      PS::CustomerAccount.default(customer_id).ps_reference_id.should == subject.ps_reference_id
    end
  end

  describe "#find" do
    let(:account_id) do
      FactoryGirl.create(:credit_card_account, { :customer_id => customer_id }).ps_reference_id 
    end
    subject { PS::CustomerAccount.find(account_id, customer_id) }

    it "should retreive the customer account" do
      subject.ps_reference_id.should == account_id
    end
  end

  describe "#default" do
    let(:default_account) do
      FactoryGirl.create(:credit_card_account, { :customer_id => customer_id })
    end
    before do 
      default_account.make_default
    end
    subject { PS::CustomerAccount.default(customer_id) }

    it "should get the default customer account" do
      subject.ps_reference_id.should == default_account.ps_reference_id
    end
  end
end
