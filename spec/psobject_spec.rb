require 'spec_helper'

class DummyClass < PS::PsObject
  attr_accessor :first_name, :last_name

  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
  end
end

describe "An instance of", PS::PsObject do
  describe "#attributes" do
    let(:attributes_hash) { { :first_name => "test", :last_name => "test" } }

    subject { DummyClass.new(attributes_hash) }

    it { subject.should respond_to(:request) }

    it "should return the attributes of subject" do
      subject.attributes.should == attributes_hash
    end
  end
end
