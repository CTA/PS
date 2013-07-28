def formatted_connection_config(format, env=:development)
  config = YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")[env]
  config[:format] = format
  config
end

def formatless_connection_config
  YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")
end

def connect
  config = formatted_connection_config("Json")
  PS::Base.establish_connection({ 
    :apikey => config[:apikey],
    :userkey => config[:userkey],
    :company_name => config[:company_name],
    :env => config[:env],
    :format => config[:format]
  })
end

def test_customer
  {
    :FirstName => "test",
    :MiddleName => "e",
    :LastName => "name",
    :Email => "example@test.com",
    :Phone => "0000000000",
    :BillingAddress1 => "1600 Pennsylvania Ave NW",
    :BillingCity => "Washington",
    :BillingState => 8,
    :BillingPostalCode => 20500,
    :BillingCountryCode => "USA",
    :ShippingSameAsBilling => 1,
    :CompanyName => "USA"
  }
end
