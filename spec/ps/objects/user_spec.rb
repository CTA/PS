require 'spec_helper'

describe "An instance of", PS::User do
  before { connect() }

  describe "#get" do
    subject { PS::User.get() }
    #NOTE: I am unsure that this even works in paysimple...
    it "should get the account user" do
      subject
    end
  end

end
