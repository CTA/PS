require 'spec_helper'

class DummyClass
  extend PS::State
end

describe PS::State do
  let(:states) { YAML.load_file("ps/util/states.yml") }
  it "should define two methods for each states" do
  end
end
