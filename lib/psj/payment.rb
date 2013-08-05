module PS
  class Payment < PsObject
    attr_accessor :ref_payment_id,:customer_id,:customer_account_id,:amount,:status,:payment_date,:invoice_id,:recurring_schedule_id,:is_debit,:payment_type,:payment_sub_type,:provider_auth_code,:trace_number,:estimate_settled_date,:actual_settled_date,:can_void_until,:invoice_number,:purchase_order_number,:order_id,:description 

    def find(customer_id, criteria=nil)
      request("listpayments", { :customerid => customer_id, :criteria => criteria })
    end

    def cancel_payment
      request("cancelpayment", { :paymentid => self.ps_reference_id })
    end

    def reverse_payment
      request("reversepayment", { :paymentid => self.ps_reference_id })
    end

    class << self 
      def reverse_payment(payment_id)
        request("reversepayment", { :paymentid => payment_id })
      end

      def cancel_payment(payment_id)
        request("cancelpayment", { :paymentid =>  payment_id })
      end

      def make(customer_id, amount, account_id=nil, cid="", order_details=nil)
        request("makepayment", { :customerid => customer_id, accountid => account_id,:amount => amount, :cid => cid , :detail => order_details })
      end
    end
  end
end
