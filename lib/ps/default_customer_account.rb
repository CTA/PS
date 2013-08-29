module PS
  class DefaultCustomerAccount < PsObject
    attr_accessor :is_credit_card, :customer_id 

    def self.find_by_customer_id(customer_id)
      request("GetDefaultCustomerAccount", { :customerId => customer_id })
    end
  end
end
