require 'spec_helper'
describe "An instance of", PS::Api::Json do
  describe "#request" do
    let(:config) { formatted_connection_config("JSON", :production) }

    subject { $api }

    it "should make a request" do
      subject.request("addcustomer", FactoryGirl.attributes_for(:customer, { :last_modified => Time.now }))
    end
  end
end
