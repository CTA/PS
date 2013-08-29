module PS
  class Customer < PsObject
    attr_accessor :first_name,:middle_name,:last_name,:email,:alt_email,:phone,:alt_phone,:fax,:web_site,:billing_address1,:billing_address2,:billing_city,:billing_state,:billing_postal_code,:billing_country_code,:shipping_same_as_billing,:shipping_address1,:shipping_address2,:shipping_city,:shipping_state,:shipping_postal_code,:shipping_country_code,:Company_name,:notes,:last_modified,:created_on

    def save
      request("addcustomer", { :customer => attributes } )
    end

    def destroy
      if self.ps_reference_id then
        request("deletecustomer", { :id => self.ps_reference_id } ) 
      else
        false
      end
    end

    def credit_card_account
      CreditCardAccount.find(self.ps_reference_id)
    end

    def set_default_customer_account(account_id)
      request("SetDefaultCustomerAccount", 
        { 
          :customerId => self.ps_reference_id, 
          :customerAccountId => account_id
        }
      )
    end

    def default_customer_account
      request("GetDefaultCustomerAccount", { :customerId => self.ps_reference_id })
    end

    class << self
      #returns [ PS::Customer, PS::CustomerAccount, Ps::Payment ]
      def create_and_make_payment(customer={}, account={}, amount=0.0, cid="")
        request("addcustomerandmakeccpayment", {
          :customer => customer, 
          :customerAccount => account, 
          :amount => amount, 
          :cid => cid
        })
      end

      def get_customer_and_default_accounts(customer_id)
        request("GetCustomerAndDefaultAccounts", { :customerid => customer_id })
      end

      def find(id)
        request("getcustomer", { :id => id })
      end

      def create(options={})
        new(options).save
      end

      def destroy(customer_id)
        request("deletecustomer", { :id => customer_id } )
      end
    end
  end
end
