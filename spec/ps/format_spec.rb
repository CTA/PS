#high level tests for the format classes
require 'spec_helper'

describe "High level format class" do
  Dir.glob("lib/ps/api/*.rb").each do |format_klass|
    require File.dirname(__FILE__)+"/../../"+format_klass
    klass = PS::Api.const_get(format_klass.scan(/[a-zA-Z]+\.rb/)[0].gsub(/\.rb/, '').capitalize)
    p klass
    describe klass do
      context "required methods" do
        it { klass.method_defined?(:request).should be_true }
        it { klass.method_defined?(:date?).should be_true }
        it { klass.method_defined?(:parse_date).should be_true }
      end
    end
  end
end
