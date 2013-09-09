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
  config = YAML.load_file(File.dirname(__FILE__)+"/config.yml")[env]
  config[:format] = format
  config
end

def formatless_connection_config(env=:development)
  YAML.load_file(File.dirname(__FILE__)+"/config.yml")[env]
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

def test_customer_account
  {
    "api_consumer_data"=>"",
    "ps_reference_id"=>0,
    "customer_id"=>0,
    "account_number"=>"4111111111111111",
    "c_c_expiry"=>"12/2015",
    "c_c_type"=>1
  }
end

def test_add_customer_and_make_cc_payment
  JSON.load('{"__type":"PsResponse:http:\/\/api.paysimple.com","CurrentPage":0,"ErrorMessage":null,"ErrorType":0,"IsSuccess":true,"ItemsPerPage":0,"PsObject":[{"__type":"PsCustomer:http:\/\/api.paysimple.com","ApiConsumerData":"","PsReferenceId":99301,"AltEmail":"testemail@paysimpledev.com","AltPhone":"","BillingAddress1":"TestBillingAddress1","BillingAddress2":"","BillingCity":"Denver","BillingCountryCode":null,"BillingPostalCode":"80202","BillingState":6,"CompanyName":"TestCompany","CreatedOn":"\/Date(1293737680899-0700)\/","Email":"testemail@paysimpledev.com","Fax":"","FirstName":"TestFirstName","LastModified":"\/Date(1293737680899-0700)\/","LastName":"TestLastName","MiddleName":"","Notes":"","Phone":"5551234567","ShippingAddress1":null,"ShippingAddress2":null,"ShippingCity":null,"ShippingCountryCode":null,"ShippingPostalCode":null,"ShippingSameAsBilling":false,"ShippingState":0,"WebSite":""},{"__type":"PsCreditCardAccount:http:\/\/api.paysimple.com","ApiConsumerData":null,"PsReferenceId":57799,"CustomerId":99301,"AccountNumber":"","CCExpiry":"12\/2011","CCType":1},{"__type":"PsPayment:http:\/\/api.paysimple.com","ApiConsumerData":null,"PsReferenceId":79188,"ActualSettledDate":"\/Date(1294038000000-0700)\/","Amount":1,"CanVoidUntil":"\/Date(1293767100000-0700)\/","CustomData":null,"CustomerAccountId":57799,"CustomerId":99301,"Description":null,"EstimateSettledDate":"\/Date(1294038000000-0700)\/","InvoiceId":0,"InvoiceNumber":null,"IsDebit":false,"OrderId":null,"PaymentDate":"\/Date(1293692400000-0700)\/","PaymentSubType":"Moto","PaymentType":1,"ProviderAuthCode":null,"PurchaseOrderNumber":null,"RecurringScheduleId":0,"RefPaymentId":0,"Status":12,"TraceNumber":"TAS121"}],"SubType":"PsCustomer,PsCustomerAccount,PsPayment","TotalItems":3}')
end

def test_ps_response_with_single_ps_object
  JSON.load('{"__type":"PsResponse:http:\/\/api.paysimple.com","CurrentPage":0,"ErrorMessage":null,"ErrorType":0,"IsSuccess":true,"ItemsPerPage":0,"PsObject":[{"__type":"PsCustomer:http:\/\/api.paysimple.com","ApiConsumerData":"","PsReferenceId":99304,"AltEmail":"testemail@paysimpledev.com","AltPhone":"","BillingAddress1":"TestBillingAddress1","BillingAddress2":"","BillingCity":"Denver","BillingCountryCode":null,"BillingPostalCode":"80202","BillingState":6,"CompanyName":"TestCompany","CreatedOn":"\/Date(1293737698321-0700)\/","Email":"testemail@paysimpledev.com","Fax":"","FirstName":"TestFirstName","LastModified":"\/Date(1293737698321-0700)\/","LastName":"TestLastName","MiddleName":"","Notes":"","Phone":"5551234567","ShippingAddress1":"TestBillingAddress1","ShippingAddress2":"","ShippingCity":"Denver","ShippingCountryCode":null,"ShippingPostalCode":"80202","ShippingSameAsBilling":false,"ShippingState":6,"WebSite":""}],"SubType":"PsCustomer","TotalItems":1}')
end

def test_ps_response_with_multiple_ps_objects
  JSON.load('{"__type":"PsResponse:http:\/\/api.paysimple.com","CurrentPage":0,"ErrorMessage":null,"ErrorType":0,"IsSuccess":true,"ItemsPerPage":0,"PsObject":[{"__type":"PsCustomer:http:\/\/api.paysimple.com","ApiConsumerData":"","PsReferenceId":99304,"AltEmail":"testemail@paysimpledev.com","AltPhone":"","BillingAddress1":"TestBillingAddress1","BillingAddress2":"","BillingCity":"Denver","BillingCountryCode":null,"BillingPostalCode":"80202","BillingState":6,"CompanyName":"TestCompany","CreatedOn":"\/Date(1293737698321-0700)\/","Email":"testemail@paysimpledev.com","Fax":"","FirstName":"TestFirstName","LastModified":"\/Date(1293737698321-0700)\/","LastName":"TestLastName","MiddleName":"","Notes":"","Phone":"5551234567","ShippingAddress1":"TestBillingAddress1","ShippingAddress2":"","ShippingCity":"Denver","ShippingCountryCode":null,"ShippingPostalCode":"80202","ShippingSameAsBilling":false,"ShippingState":6,"WebSite":""}, {"__type":"PsCustomer:http:\/\/api.paysimple.com","ApiConsumerData":"","PsReferenceId":99304,"AltEmail":"testemail@paysimpledev.com","AltPhone":"","BillingAddress1":"TestBillingAddress1","BillingAddress2":"","BillingCity":"Denver","BillingCountryCode":null,"BillingPostalCode":"80202","BillingState":6,"CompanyName":"TestCompany","CreatedOn":"\/Date(1293737698321-0700)\/","Email":"testemail@paysimpledev.com","Fax":"","FirstName":"TestFirstName","LastModified":"\/Date(1293737698321-0700)\/","LastName":"TestLastName","MiddleName":"","Notes":"","Phone":"5551234567","ShippingAddress1":"TestBillingAddress1","ShippingAddress2":"","ShippingCity":"Denver","ShippingCountryCode":null,"ShippingPostalCode":"80202","ShippingSameAsBilling":false,"ShippingState":6,"WebSite":""}],"SubType":"PsCustomer","TotalItems":1}')
end
