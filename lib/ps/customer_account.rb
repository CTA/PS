module PS
  class CustomerAccount < PsObject
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
      def find(account_id)
        request("GetCustomerAccountByAccountId", { :accountId => account_id })
      end

      def default(customer_id)
        request("GetDefaultCustomerAccount", { :customerId => customer_id })
      end

    end
  end
end
