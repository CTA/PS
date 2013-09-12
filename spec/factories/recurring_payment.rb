FactoryGirl.define do
  factory :recurring_payment do
    # customer_id                   #PS::Customer.create(test_customer()).ps_reference_id
    # customer_account_id           #PS::CustomerAccount.new(test_customer_account()).ps_reference_id
    # recurring_schedule_type       RecurringScheduleType::PAYMENT_PLAN
    # start_date                    Time.now
    # has_end_date                  false
    # end_date                      ""
    # billing_frequency_type        BillingFrequencyType  WEEKLY
    # billing_frequency_param       ""
    # payment_amount                100
    # first_payment_done            true
    # first_payment_amount          100
    # first_payment_date            Time.now-(86400*3)
    # total_due_amount              1000
    # total_number_of_payments      10
    # balance_remaining             900
    # number_of_payments_remaining  9
    # invoice_no                    ""
    # order_id                      ""
    # description                   ""
    # schedule_stats                PS::ScheduleStatus::ACTIVE
    # number_of_payments_made       1
    # total_amount_paid             100
    # date_of_last_payment_made     Time.now-(86400*3)
    # pause_until_date              ""
  end
end
