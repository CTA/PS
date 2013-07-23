#require File.dirname(__FILE__)+"/psobject.rb"
module PS
  class Customer 
    #include ActiveModel::Model

    attr_accessor :id, :FirstName,:MiddleName,:LastName,:Email,:AltEmail,:Phone,:AltPhone,:Fax,:WebSite,:BillingAddress1,:BillingAddress2,:BillingCity,:BillingState,:BillingPostalCode,:BillingCountryCode,:ShippingSameAsBilling,:ShippingAddress1,:ShippingAddress2,:ShippingCity,:ShippingState,:ShippingPostalCode,:ShippingCountryCode,:CompanyName,:Notes,:LastModified,:CreatedOn

    def initialize(params = {})
      params.each do |k, v|
        next unless self.class.method_defined?(k)
        if v.class == String then
          if v.include?("Date") then
            v = PS.json_date_parse(v)
          end
        end
        self.send("#{k}=", v)
      end
    end
    
    def self.create(options={})
    end

    def self.find(*args)
      if args.include?(:id) || args.include?("id")
        @api.get_customer({ :id => args[:id] })
      end
      PS::Util.convert_to_ps_object(results)
    end

  end
end
