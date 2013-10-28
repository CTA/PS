require 'spec_helper'

describe String do
  describe "#to_snake_case" do
    let(:string) { "CamelCase" }
    subject { string.to_snake_case }

    it "should convert the string to snake_case" do
      subject.should == "camel_case"
    end
  end
  
  describe "#to_camel_case" do
    let(:string) { "snake_case" }
    subject { string.to_camel_case }

    it "should convert the sring to CamelCase" do
      subject.should == "SnakeCase"
    end
  end
end
