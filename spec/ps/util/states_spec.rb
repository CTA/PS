require 'spec_helper'

class DummyClass
  extend PS::State
end

describe PS::State do
  let(:states) {  }
  subject { PS::State }


  YAML.load_file("lib/ps/util/states.yml").each do |k, state|
    context "being #{state["name"]}" do
      let(:abbrev) { PS::States.const_get(state["abbreviation"].upcase) }

      it "should have the state name as a method" do
        subject.send((state["name"].downcase.gsub(/ /, '_')).to_sym).should == abbrev
      end

      it "should have the state abbr as a method" do
        (subject.send(state["abbreviation"].downcase.to_sym)).should == abbrev
      end
    end
  end
end
