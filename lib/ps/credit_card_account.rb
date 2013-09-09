module PS
  class CreditCardAccount < CustomerAccount
    attr_accessor :c_c_expiry, :c_c_ctype, :account_number 

    def self.create(params={})
      self.new(params).save
    end

    def save
      request("addcustomercreditcardaccount", { :customerAccount => attributes })
    end

    def update
      request("updatecustomercreditcardaccount", { :customer => attributes })
    end

    def delete
      request("deletecustomercreditcardaccount", { :accountid => self.customer_id })
    end

    def self.default_for_customer_id(customer_id)
      request("getdefaultcreditcardaccount", { :customerid => self.customer_id })
    end
  end
end
