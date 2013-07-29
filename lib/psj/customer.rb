module PS
  class Customer < PsObject
    attr_accessor :ps_reference_id, :first_name,:middle_name,:last_name,:email,:alt_email,:phone,:alt_phone,:fax,:web_site,:billing_address1,:billing_address2,:billing_city,:billing_state,:billing_postal_code,:billing_country_code,:shipping_same_as_billing,:shipping_address1,:shipping_address2,:shipping_city,:shipping_state,:shipping_postal_code,:shipping_country_code,:Company_name,:notes,:last_modified,:created_on

    def initialize(params = {})
      params.each do |k, v|
        next unless self.class.method_defined?(k)
        send("#{k}=", v)
      end
    end
    
    def self.create(options={})
      customer = new(options)
      customer.save
    end

    def save
      request("addcustomer", { :customer => attributes } )
    end

    def self.find(*args)
      if args[0].class == Fixnum then 
        results = request("getcustomer", { :id => args[0] })
      elsif args[0].class == Hash then
        #do a search
      else
        #TODO:raise data type exception
      end
    end

    def self.all(page=1)
      request("listcustomers", { :criteria => { :Page => page, :ItemsPerPage => 200} })
    end

    def delete
      request("deletecustomer", { :id => self.ps_reference_id } )
    end
  end
end
