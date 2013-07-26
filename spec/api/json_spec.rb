require 'spec_helper'
require File.dirname(__FILE__)+"/../../lib/psj/api/json"
describe "An instance of", PS::Api::JSON do
  describe "#request" do
    let(:config) { formatted_connection_config("JSON") }

    subject { PS::Api::JSON.new }

    before do
      PS::Base.stub(:host) { "https://sandbox-api.paysimple.com/3.00/paysimpleapi" } 
      subject.instance_variables.each do |v|
        subject.instance_variable_set(v.to_s, config[v.to_s[1..-1].to_sym])
      end
    end


    it "should make a request" do
      subject.request("getstates")
    end
  end
end
