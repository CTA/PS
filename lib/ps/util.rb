module PS
  module Util
    def self.convert_to_ps_object(response)
      types = {
        "PsCustomer" => PS::Customer
      }
      klass = types[response.sub_type]
      if response.ps_object.length == 1 then
        klass.construct_from(response.ps_object[0])
      elsif response.ps_object.length > 1
        response.ps_object.map { |object| klass.construct_from(object) }
      else
        response
      end
    end
  end
end
