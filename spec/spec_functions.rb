#the yaml file for config should be in the following format:
#:development:
#  :apikey: ""
#  :userkey: "" 
#  :env: "development"
#  :format: "json"
#  :company_name: ""
#:production:
#  :apikey: ""
#  :userkey: "" 
#  :env: "production"
#  :format: "json"
#  :company_name: ""
def formatted_connection_config(format, env=:development)
  config = YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")[env]
  config[:format] = format
  config
end

def formatless_connection_config(env=:development)
  YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")[env]
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

def test_customer_camel
  {
    "FirstName" => "test",
    "MiddleName" => "e",
    "LastName" => "name",
    "Email" => "example@test.com",
    "Phone" => "0000000000",
    "BillingAddress1" => "1600 Pennsylvania Ave NW",
    "BillingCity" => "Washington",
    "BillingState" => 8,
    "BillingPostalCode" => 20500,
    "BillingCountryCode" => "USA",
    "ShippingSameAsBilling" => 1,
    "CompanyName" => "USA"
  }
end

def test_customer
  {
    :first_name => "test",
    :middle_name => "e",
    :last_name => "name",
    :email => "example@test.com",
    :phone => "0000000000",
    :billing_address1 => "1600 Pennsylvania Ave NW",
    :billing_city => "Washington",
    :billing_state => 8,
    :billing_postal_code => 20500,
    :billing_country_code => "USA",
    :shipping_same_as_billing => 1,
    :company_name => "USA"
  }
end

def test_response
  {
    "PsObject" => [
      {
        "TestAttr" => "value",
        "AnotherTestAttr" => 1
      },
      {
        "TestAttr" => "value",
        "AnotherTestAttr" => 1
      }
    ]
  }
end

def test_response_snake
  {
    "PsObject" => [
      {
        "test_attr" => "value",
        "another_test_attr" => 1
      },
      {
        "test_attr" => "value",
        "another_test_attr" => 1
      }
    ]
  }
end
