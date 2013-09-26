module PS
  class CustomerAccount < Object
    attr_accessor :customer_id

    def make_default
      request("SetDefaultCustomerAccount", 
        { 
          :customerId => self.customer_id, 
          :customerAccountId => self.ps_reference_id 
        }
      )
    end

    class << self 
      def find(account_id, customer_id)
        #The name of this method in Paysimple is sooo misleading...
        request("GetCustomerAccountByAccountId", { :accountId => account_id, :customerId => customer_id }, &instantiate_object)
      end

      def default(customer_id)
        request("GetDefaultCustomerAccount", { :customerId => customer_id }, &instantiate_object)
      end
    end
  end
end
