require "spec_helper"

describe "An instance of", PS::Base do

  context "given a valid connection Hash" do 
    context "with the format being JSON" do
      let(:ps_base) { PS::Base }
      subject { ps_base.establish_connection(formatted_connection_config("JSON")) }

      it "should create a connection to the Paysimple API" do
        subject
        $api.class.should == PS::Api::Json
      end

      it "Should output the connection config" do
        $stdout.should_receive(:puts)
        subject
        ps_base.current_connection()
      end
    end

    context "with no format provided" do
      subject { PS::Base.establish_connection(formatless_connection_config()) }

      it "should default to JSON" do
        subject
        $api.class.should == PS::Api::Json
      end
    end
  end

  context "given an invalid connectiond Hash" do
    subject { PS::Base.establish_connection({}) }

    it "should raise an exception" do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end
