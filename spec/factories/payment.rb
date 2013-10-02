require 'factory_girl'

FactoryGirl.define do
  factory :payment, class: PS::Payment do
     customer_id           0
     customer_account_id   0
     amount                199.99
     payment_date          Time.now
     is_debit              true
     recurring_schedule_id 0
  end
end
