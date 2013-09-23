module PS
  class PaymentStatusFilter < Object
    attr_accessor :all, :pending, :posted, :settled, :failed, :resubmitted, :voided, :reversed, :saved, :scheduled, :reverse_posted, :charge_back, :close_charge_back, :authorized, :returned, :reverse_charge_back, :reverse_NSF, :reverse_return, :refund_settled
    
  end
end
