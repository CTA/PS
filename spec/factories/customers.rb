require 'factory_girl'

FactoryGirl.define do
  factory :customer, class: PS::Customer do
    first_name               "test"
    middle_name              "e"
    last_name                "name"
    email                    "example@test.com"
    phone                    "0000000000"
    billing_address1        "1600 Pennslyvania Ave NW"
    billing_city             "Seattle"
    billing_state            8
    billing_postal_code      20500
    billing_country_code     "USA"
    shipping_same_as_billing 1
    company_name             "USA"
  end
end
