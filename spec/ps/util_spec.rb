require 'spec_helper'

describe PS::Util do
  context "Given multiple ps objects" do
    let(:ps_objects) do
      [
        { "__type" => "PsCustomer:http://api.paysimple.com" },
        { "__type" => "PsCreditCardAccount:http://api.paysimple.com" },
        { "__type" => "PsPayment:http://api.paysimple.com" }
      ]
    end
    subject { PS::Util.instantiate_ps_objects(ps_objects) }

    it "should instantiate the appropriate ps objects" do
      objects = subject
      objects[0].class.should == PS::Customer
      objects[1].class.should == PS::CreditCardAccount
      objects[2].class.should == PS::Payment
    end
  end

  context "given ane ps object" do
    let(:ps_object) { { "__type" => "PsCustomer:http://api.paysimple.com" } }
    subject { PS::Util.instantiate_ps_objects(ps_object) }

    it "should instantiate the ps object" do
      subject.class.should == PS::Customer
    end
  end
end
