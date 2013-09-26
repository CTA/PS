module PS
  class CreditCardAccount < CustomerAccount
    attr_accessor :c_c_expiry, :c_c_type, :account_number

    def save
      begin
        save!()
        true
      rescue
        false
      end
    end

    def save!
      request("addcustomercreditcardaccount", { :customerAccount => attributes }, &update_self)
    end

    def update
      request("updatecustomercreditcardaccount", { :customerAccount => attributes() })
      true
    end

    def delete
      request("deletecustomercreditcardaccount", { :accountId => self.ps_reference_id })
      true
    end

    def self.default_for_customer_id(customer_id)
      request("getdefaultcreditcardaccount", { :customerId => customer_id }, &instantiate_object)
    end

    def self.create(params={})
      cc = self.new(params)
      cc.save()
      return cc
    end
  end
end
