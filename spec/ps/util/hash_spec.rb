require 'spec_helper'

describe Hash do
  describe "#camel_case_keys" do
    let(:hash) do
      { :snake_case => "rawr",
        :foo => "bar"
      }
    end
    subject { hash.camel_case_keys }

    it "should convert the keys to camel case" do
      keys = subject.keys
      keys[0].should == "SnakeCase"
      keys[1].should == "Foo"
    end
  end

  describe "#snake_case_keys" do
    let(:hash) do
      { :CamelCase => "rawr",
        :Foo => "bar"
      }
    end
    subject { hash.snake_case_keys }

    it "should convert the keys to snake case" do
      keys = subject.keys
      keys[0].should == "camel_case"
      keys[1].should == "foo"
    end
  end
end
