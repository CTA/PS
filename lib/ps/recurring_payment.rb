module PS
	class RecurringPayment < PsObject
	  attr_accessor :customer_id, :customer_account_id, :recurring_schedule_type, :start_date, :has_end_date, :end_date, :billing_frequency_type, :billing_frequency_param, :payment_amount, :first_payment_done, :first_payment_amount, :first_payment_date, :total_due_amount, :total_number_of_payments, :balance_remaining, :number_of_payments_remaining, :invoice_no, :order_id, :description, :schedule_status, :number_of_payment_made, :total_amount_paid, :date_of_last_payment_made, :pause_until_date

		def save
      request("addrecurringpayment", { :recurring_payment => attributes } )
		end

		def edit
			request("modifyrecurringpayment", { :payment_schedule => attributes } )
		end

		def suspend
			request("suspendrecurringpaymentschedule", { :schedule_id => self.ps_reference_id } )
		end

		def resume
			request("resumerecurringpaymentschedule", { :schedule_id => self.ps_reference_id } )
    end

	  def destroy
      request("deleterecurringschedule", { :recurring_payment => attributes } )
		end	

		def self.create(params={})
      recurring_payment = new(params)
			recurring_payment.save
		end

		def self.list(start_date, end_date, customer_id, filter, criteria)
			request("listrecurringpayments", { :start_date => start_date, :end_date => end_date, :customer_id => customer_id, :ps_recurring_payment_filter => filter, :ps_paged_criteria => criteria } )
		end

	end
end
