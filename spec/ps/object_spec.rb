require 'spec_helper'

class PS::DummyClass < PS::Object
  attr_accessor :first_name, :last_name

  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
  end
end

describe "An instance of", PS::Object do
  describe "#attributes" do
    let(:attributes_hash) { { :first_name => "test", :last_name => "test" } }

    subject { PS::DummyClass.new(attributes_hash) }

    it { subject.should respond_to(:request) }

    it "should return the attributes of subject" do
      subject.attributes.should == attributes_hash
    end
  end

  describe "#new" do
    let(:customer) { FactoryGirl.attributes_for(:customer) }
    subject { PS::Customer.new(customer) }

    it "should assign attributes for the appropriate class" do 
      subject.instance_variables.each do |v|
        subject.send(v.to_s[1..-1]).should eq(customer[v.to_s[1..-1].to_sym])
      end
    end
  end
end
