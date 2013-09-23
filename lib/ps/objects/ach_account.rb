module PS
  class AchAccount < CustomerAccount
    attr_accessor :is_checking_account, :routing_number, :account_number, :bank_name 

    def self.create(params={})
      self.new(params).save
    end

    def save
      request("addcustomerachaccount", { :customerAccount => attributes })
    end

    def update
      request("updatecustomerachaccount", { :customerAccount => attributes })
    end

    def delete
      request("deletecustomerachaccount", { :accountid => self.customer_id })
    end
  end
end
