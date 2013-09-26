require 'factory_girl'

FactoryGirl.define do
  factory :ach_account, class: PS::AchAccount do
    is_checking_account     true
    routing_number          "086506955"
    account_number          "411111111"
    bank_name               "Some Holdings"
    customer_id             0
  end
end
