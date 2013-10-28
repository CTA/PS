require 'spec_helper'

describe "An instance of", PS::AchAccount do 
  before { connect() }
  let(:customer_id) do 
    PS::Customer.create(FactoryGirl.attributes_for(:customer)).ps_reference_id
  end

  describe "#create" do
    subject do
      PS::AchAccount.create(
        FactoryGirl.attributes_for(:ach_account, { :customer_id => customer_id })
      ) 
    end

    it "should create an ach account" do
      subject.ps_reference_id.should_not be_nil
    end
  end

  describe "instantiated" do
    let(:ach_account) do
      PS::AchAccount.create(
        FactoryGirl.attributes_for(:ach_account, { :customer_id => customer_id })
      ) 
    end

    describe "#update" do
      subject { ach_account.update }

      it "should update attributes" do
        ach_account.bank_name = "test"
        subject
      end
    end

    describe "delete" do
      subject { ach_account.delete }

      it "should delete the customer" do
        subject
      end
    end

    context "bad save" do
      subject do
        PS::AchAccount.new(
          FactoryGirl.attributes_for(:ach_account)
        ).save()
      end

      it "should catch the exception and return false" do
        subject.should == false
      end
    end
  end
end
