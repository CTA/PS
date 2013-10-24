module PS
  class AchAccount < CustomerAccount
    attr_accessor :is_checking_account, :routing_number, :account_number, :bank_name 

    def self.create(params={})
      aa = self.new(params)
      aa.save
      return aa
    end

    def save
      begin
        save!()
        true
      rescue Exception
        false
      end
    end

    def save!
      request("addcustomerachaccount", { :customerAccount => attributes }, &update_self)
    end

    def update
      request("updatecustomerachaccount", { :customerAccount => attributes })
      true
    end

    def delete
      request("deletecustomerachaccount", { :accountId => self.ps_reference_id })
      true
    end
  end
end
