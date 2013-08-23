require 'rspec'
require File.dirname(__FILE__)+"/../../lib/paysiple/util.rb"

class DummyClass
  extend PS::Util
end

describe PS::Util do

  it "should convert a request into the corresponding PsObject subclass" do
  end

end
