module PS
  module Util
    ##
    # objects contained within PS::Response.ps_object have a '__type' attribute
    # that signals the subclass of PS::Object they represent. This constant
    # provides access to what class needs to be instantiated relative to what
    # paysimple return.
    PS_OBJECTS = {
      "PsCustomer" => PS::Customer,
      "PsCustomerAccount" => PS::CustomerAccount,
      "PsCreditCardAccount" => PS::CreditCardAccount,
      "PsAchAccount" => PS::AchAccount,
      "PsPayment" => PS::Payment,
      "PsDefaultCustomerAccount" => PS::CustomerAccount
    }

    def self.instantiate_ps_objects(ps_objects)
      case ps_objects
      when Array
        ps_objects.map { |obj| instantiate_ps_objects(obj) }
      when Hash
        klass_name = ps_objects.delete("__type").scan(/[a-zA-Z]+:/)[0].delete(":")
        PS_OBJECTS[klass_name].new(ps_objects.symbolize_keys)
      end
    end
  end
end
