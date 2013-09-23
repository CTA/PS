require 'factory_girl'

FactoryGirl.define do
  factory :customer_account, :class => PS::CustomerAccount do
    customer_id 0
  end
end
