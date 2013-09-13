module PS
  class Customer < PsObject
    attr_accessor :first_name,:middle_name,:last_name,:email,:alt_email,:phone,:alt_phone,:fax,:web_site,:billing_address1,:billing_address2,:billing_city,:billing_state,:billing_postal_code,:billing_country_code,:shipping_same_as_billing,:shipping_address1,:shipping_address2,:shipping_city,:shipping_state,:shipping_postal_code,:shipping_country_code,:Company_name,:notes,:last_modified,:created_on

    def save
    end

    def save!
      request_and_update_self("addcustomer", { :customer => attributes }, self)
    end

    def destroy
      if self.ps_reference_id then
        request("deletecustomer", { :id => self.ps_reference_id } ) 
        true
      else
        false
      end
    end

    def credit_card_account
      CreditCardAccount.find(self.ps_reference_id)
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
      def create_and_make_payment(customer={}, account={}, amount=0.0, cid="")
        request_and_instantiate("addcustomerandmakeccpayment", {
          :customer => customer, 
          :customerAccount => account, 
          :amount => amount, 
          :cid => cid
        })
      end

      def get_customer_and_default_accounts(customer_id)
        request_and_instantiate("GetCustomerAndDefaultAccounts", { :customerid => customer_id })
      end

      def find(id)
        request_and_instantiate("getcustomer", { :id => id })
      end

      def create(options={})
        request_and_instantiate("addcustomer", { :customer => options })
      end

      def destroy(customer_id)
        request("deletecustomer", { :id => customer_id } )
        true
      end
    end
  end
end
