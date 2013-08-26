module PS
  class Customer < PsObject
    attr_accessor :first_name,:middle_name,:last_name,:email,:alt_email,:phone,:alt_phone,:fax,:web_site,:billing_address1,:billing_address2,:billing_city,:billing_state,:billing_postal_code,:billing_country_code,:shipping_same_as_billing,:shipping_address1,:shipping_address2,:shipping_city,:shipping_state,:shipping_postal_code,:shipping_country_code,:Company_name,:notes,:last_modified,:created_on

    def save
      request("addcustomer", { :customer => attributes } )
    end

    def destroy
      request("deletecustomer", { :id => self.ps_reference_id } )
    end

    def credit_card_account
      CreditCardAccount.find(self.ps_reference_id)
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

      def find(id)
        request("getcustomer", { :id => id })
      end

      def create(options={})
        customer = new(options)
        customer.save
      end

      def destroy(customer_id)
        request("deletecustomer", { :id => customer_id } )
      end
    end
  end
end
