require 'factory_girl'

FactoryGirl.define do
  factory :credit_card_account, :class => PS::CreditCardAccount do
    #customer_id      please derive
    #ps_reference_id  please derive
    api_consumer_data ""
    account_number    "4111111111111111"
    c_c_expiry        "12/2015"
    c_c_type          1
  end
end
