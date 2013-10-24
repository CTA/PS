require 'factory_girl'

FactoryGirl.define do
  factory :ach_account, class: PS::AchAccount do
    is_checking_account     true
    routing_number          "307075259"
    account_number          "751111111"
    bank_name               "Simply Bank"
    customer_id             0
  end
end
