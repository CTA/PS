module PS
  class CreditCardAccount < CustomerAccount
    attr_accessor :c_c_expiry, :c_c_type, :account_number

    def self.create(params={})
      cc = self.new(params)
      cc.save()
      return cc
    end

    def save
      request("addcustomercreditcardaccount", { :customerAccount => attributes }, &update_self)
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
