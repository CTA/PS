<<<<<<< HEAD:lib/paysimple/customer.rb
module Paysimple
  class Customer
=======
#require File.dirname(__FILE__)+"/psobject.rb"
module PS
  class Customer < PsObject
    #include ActiveModel::Model
>>>>>>> Renamed some files:lib/psj/customer.rb

    #CustomerId == id => true
    attr_accessor :id, :FirstName,:MiddleName,:LastName,:Email,:AltEmail,:Phone,:AltPhone,:Fax,:WebSite,:BillingAddress1,:BillingAddress2,:BillingCity,:BillingState,:BillingPostalCode,:BillingCountryCode,:ShippingSameAsBilling,:ShippingAddress1,:ShippingAddress2,:ShippingCity,:ShippingState,:ShippingPostalCode,:ShippingCountryCode,:CompanyName,:Notes,:LastModified,:CreatedOn

<<<<<<< HEAD:lib/paysimple/customer.rb
    def initialize
=======
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
    
    def self.all
      run_callbacks :all do
        results = $api.search_customer({:fuzzySearch => 0, :PsPagedCriteria => {} })
      end
>>>>>>> Renamed some files:lib/psj/customer.rb
    end

    def self.create
    end

    def self.find(*args)
      if args.include?(:id) || args.include?("id")
        @api.get_customer({ :id => args[:id] })
      end
<<<<<<< HEAD:lib/paysimple/customer.rb
=======
      PS::Util.convert_to_ps_object(results)
>>>>>>> Renamed some files:lib/psj/customer.rb
    end

  end
end
