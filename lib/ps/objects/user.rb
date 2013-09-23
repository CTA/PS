module PS
  class User < Object
    attr_accessor :ps_reference_id, :first_name, :last_name, :company, :email, :phone
    
    def self.get
      request("getuserinfo")
    end

  end
end
