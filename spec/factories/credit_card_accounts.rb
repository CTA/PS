require 'factory_girl'

FactoryGirl.define do
  factory :credit_card_account, :class => PS::CreditCardAccount do
    customer_id       0
    #ps_reference_id  please derive
    account_number    "4111111111111111"
    c_c_expiry        "12/2015"
    c_c_type          1
  end
end
