# Paysimple

A multiformat integration with paysimple's version 3 api. 

We hope to replace the already existing paysimple gem that hasn't been updated in years.

## Installation

Add this line to your application's Gemfile:

    gem 'paysimple'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paysimple

## Usage
  please note that the documention, and the gem are still works in progress. Clone this repo for usage at your own risk.

### Connection to paysimple
    require 'paysimple' 
    PS::Base.establish_connection(
      :format => "JSON",
      :apikey => your_api_key,
      :userkey => the_user_key,
      :company_name => your_company_name
    )
### Creating a customer
    require 'paysimple'
    PS::Base.establish_connection( ... )

    customer_params = {                                                  
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
     :shipping_same_as_billing => 1
    }

    customer = PS::Customer.create(customer_params)
    p customer
    # => 
      #<PS::Customer ps_reference_id: 1, billing_address1: '1600 Pennsylvania Ave NW', billing_city: 'Washington', billing_postal_code: '20500', billing_state: 8, email: 'example@test.com', first_name: 'test', last_name: 'e', phone: '0000000000', shipping_same_as_billing: 1>

### Making a payment
    customer = PS::Customer.find(1)
    cc = PS::CreditCardAccount.create({ 
      :account_number => "4111111111111111",
      :c_c_expiry => "2014/12",
      :c_c_type => CreditCardIssuer::VISA,
      :customer_id => customer.ps_reference_id
    })
    payment = Payment.make(customer.ps_reference_id, 100000, cc.ps_reference_id)
### Alternative method of making a payment
    customer = {                                                  
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
     :shipping_same_as_billing => 1
    }
    customer_account = {
      :account_number => "4111111111111111",
      :c_c_expiry => "2014/12",
      :c_c_type => CreditCardIssuer::VISA,
    }
    amount = 100

    response = PS::Customer.create_and_make_cc_payment(
      customer,
      customer_account,
      amount
    )

    response.map(&:class) #=> [ PS::Customer, PS::CreditCardAccount, PS::Payment ]


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
