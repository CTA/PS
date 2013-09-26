module PS
  class Customer < Object
    attr_accessor :first_name,:middle_name,:last_name,:email,:alt_email,:phone,:alt_phone,:fax,:web_site,:billing_address1,:billing_address2,:billing_city,:billing_state,:billing_postal_code,:billing_country_code,:shipping_same_as_billing,:shipping_address1,:shipping_address2,:shipping_city,:shipping_state,:shipping_postal_code,:shipping_country_code,:company_name,:notes,:last_modified,:created_on

    def save
      begin
        save!()
        true
      rescue Exception
        false
      end
    end

    def save!
      request("addcustomer", { :customer => attributes }, &update_self)
    end

    def destroy
      if self.ps_reference_id then
        request("deletecustomer", { :id => self.ps_reference_id } ) 
        true
      else
        false
      end
    end

    def payments
      if self.ps_reference_id then
        Payment.find(self.ps_reference_id, &instantiate_object)
      else
        false
      end
    end

    def set_default_customer_account(account_id)
      CustomerAccount.find(account_id).make_default
    end

    def default_customer_account
      CustomerAccount.default(self.ps_reference_id)
    end

    def default_credit_card_account
      CreditCardAccount.default_for_customer_id(self.ps_reference_id)
    end

    class << self
      #TODO: Account param should be a PS::CreditCardAccount, ensure this
      #returns [ PS::Customer, PS::CustomerAccount, Ps::Payment ]
      def create_and_make_cc_payment(customer={}, account={}, amount=0.0, cid="")
        request("addcustomerandmakeccpayment", {
          :customer => customer, 
          #account must have a customer_id of 0
          :customerAccount => account, 
          :amount => amount, 
          :cid => cid
        }, &instantiate_object)
      end

      def create_and_make_ach_payment(customer={}, account={}, amount=0.0, cid="")
        request("addcustomerandmakeachpayment", {
          :customer => customer, 
          :customerAccount => account, 
          :amount => amount, 
          :cid => cid
        }, &instantiate_object)
      end

      def get_customer_and_default_accounts(customer_id)
        request("GetCustomerAndDefaultAccounts", { :customerId => customer_id }, &instantiate_object)
      end

      def find(id)
        request("getcustomer", { :id => id }, &instantiate_object)
      end

      def create(options={})
        customer = self.new(options)
        customer.save!
        return customer
      end
    end
  end
end
