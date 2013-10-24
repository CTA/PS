require 'spec_helper'
describe "An instance of PS::Api::json" do
  before { connect }
  #TODO test date formatting 
  describe "#request" do
    subject { $api }

    it "should make a request" do
      subject.request("addcustomer", FactoryGirl.attributes_for(:customer, { :last_modified => Time.now }))
    end
  end
end
