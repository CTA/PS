require 'rspec'
require File.dirname(__FILE__)+"/../lib/paysimple.rb"

describe Paysimple do

  describe "date formatting" do

    it "should format a time object to a Paysimple Time Object" do
    end

    it "should parse a paysimple time format to a Time object" do
    end
  end

  describe "requests" do

    before(:each) do
    end

    it "should make a call to the api" do
      Paysimple.connection(@config[:apikey], @config[:userkey], "loadmax", "production")
      Paysimple.request("getcustomer", { :id => 119932} )
    end

    it "should throw an exception upon failed request" do
     # expect {@api.get_customer({ :id => 55555 }).expect }.to raise_error
    end

  end

end
