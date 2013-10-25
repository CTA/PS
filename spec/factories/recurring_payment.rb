FactoryGirl.define do
  factory :recurring_payment, :class => PS::RecurringPayment do
     customer_id                   0
     customer_account_id           0
     schedule_type                 RecurringScheduleType::PAYMENT_PLAN
     start_date                    Time.now
     has_end_date                  false
     billing_frequency_type        BillingFrequencyType::WEEKLY
     billing_frequency_param       1
     payment_amount                100
     first_payment_done            true
     first_payment_amount          100
     first_payment_date            Time.now-(86400*3)
     total_due_amount              1000
     total_number_of_payments      10
     balance_remaining             900
     number_of_payments_remaining  9
     invoice_no                    0
     order_id                      0
     schedule_stats                PS::ScheduleStatus::ACTIVE
     number_of_payments_made       1
     total_amount_paid             100
     date_of_last_payment_made     Time.now-(86400*3)
  end
end
