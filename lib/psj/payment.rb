module PS
  class Payment
    attr_accessor :ref_payment_id,:customer_id,:customer_account_id,:amount,:status,:payment_date,:invoice_id,:recurring_schedule_id,:is_debit,:payment_type,:payment_sub_type,:provider_auth_code,:trace_number,:estimate_settled_date,:actual_settled_date,:can_void_until,:invoice_numbe,:purchase_order_number,:order_id,:description 
  end
end
