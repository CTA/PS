module Paysimple
  class Customer

    #CustomerId == id => true
    attr_accessor :id, :FirstName,:MiddleName,:LastName,:Email,:AltEmail,:Phone,:AltPhone,:Fax,:WebSite,:BillingAddress1,:BillingAddress2,:BillingCity,:BillingState,:BillingPostalCode,:BillingCountryCode,:ShippingSameAsBilling,:ShippingAddress1,:ShippingAddress2,:ShippingCity,:ShippingState,:ShippingPostalCode,:ShippingCountryCode,:CompanyName,:Notes,:LastModified,:CreatedOn

    def initialize
    end

    def self.create
    end

    def self.find(*args)
      if args.include?(:id) || args.include?("id")
        @api.get_customer({ :id => args[:id] })
      end
    end

  end
end
