module PS
  class User < Object
    attr_accessor :ps_reference_id, :first_name, :last_name, :company, :email, :phone
    
    #NOTE: This doesn't work in paysimple... 
    def self.get
      request("getuserinfo", &instantiate_object)
    end
  end
end
