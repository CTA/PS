module PS
  class Customer < PsObject
    attr_accessor :PsReferenceId, :FirstName,:MiddleName,:LastName,:Email,:AltEmail,:Phone,:AltPhone,:Fax,:WebSite,:BillingAddress1,:BillingAddress2,:BillingCity,:BillingState,:BillingPostalCode,:BillingCountryCode,:ShippingSameAsBilling,:ShippingAddress1,:ShippingAddress2,:ShippingCity,:ShippingState,:ShippingPostalCode,:ShippingCountryCode,:CompanyName,:Notes,:LastModified,:CreatedOn

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
      request("deletecustomer", { :id => self.PsReferenceId } )
    end
  end
end
