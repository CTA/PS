require 'spec_helper'
require File.dirname(__FILE__)+"/../../lib/ps/api/json"
describe "An instance of", PS::Api::Json do
  describe "#request" do
    let(:config) { formatted_connection_config("JSON", :production) }

    subject { PS::Api::Json.new }

    before do
      PS::Base.stub(:host) { "https://api.paysimple.com/3.00/paysimpleapi" } 
      subject.instance_variables.each do |v|
        subject.instance_variable_set(v.to_s, config[v.to_s[1..-1].to_sym])
      end
    end

    it "should make a request" do
      subject.request("listlineitems")
    end
  end
end
