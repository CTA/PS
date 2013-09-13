require 'factory_girl'

FactoryGirl.define do
  #customer = PS::Customer.create(FactoryGirl.attributes_for(:customer))
  factory :payment, class: PS::Payment do
    # customer_id           customer.ps_reference_id
    # customer_account_id   customer.default_customer_account(customer.ps_reference_id).ps_reference_id
    # amount                199.99
    # payment_date          Time.now
    # is_debit              true
  end
end
