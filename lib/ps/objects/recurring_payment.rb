module PS
  class RecurringPayment < Object
    attr_accessor :customer_id, :customer_account_id, :schedule_type, :start_date, :has_end_date, :end_date, :billing_frequency_type, :billing_frequency_param, :payment_amount, :first_payment_done, :first_payment_amount, :first_payment_date, :total_due_amount, :total_number_of_payments, :balance_remaining, :number_of_payments_remaining, :invoice_no, :order_id, :description, :schedule_status, :number_of_payment_made, :total_amount_paid, :date_of_last_payment_made, :pause_until_date

    def save
      begin 
        save!()
        true
      rescue Exception
        false
      end
    end

    def save!
      request("addrecurringpayment", { :recurringPayment => attributes }, &update_self)
    end

    def update
      request("modifyrecurringpaymentschedule", { :paymentSchedule => attributes })
      true
    end

    def suspend
      request("suspendrecurringpaymentschedule", { :scheduleId => self.ps_reference_id }, &update_self)
      true
    end

    def resume
      request("resumerecurringpaymentschedule", { :scheduleId => self.ps_reference_id }, &update_self)
      true
    end

    def destroy
      request("deleterecurringschedule", { :scheduleId => self.ps_reference_id })
      true
    end	

    def self.create(params={})
      recurring_payment = new(params)
      recurring_payment.save()
      return recurring_payment
    end

    def self.list(start_date, end_date, customer_id, filter, criteria)
      request("listrecurringpayments", { :startDate => start_date, :endDate => end_date, :customerId => customer_id, :filter => filter, :criteria => criteria }, &instantiate_object)
    end

    def self.find(schedule_id)
      request("GetRecurringPaymentSchedule", { :scheduleId => schedule_id }, &instantiate_object)
    end
  end
end
