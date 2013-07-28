module PS
  module Util
    def self.convert_to_ps_object(response)
      types = {
        "PsCustomer" => PS::Customer
      }
      klass = types[response['SubType']]
      if response['PsObject'].length == 1 then
        klass.construct_from(response['PsObject'][0])
      elsif response['PsObject'].length > 1
        response['PsObject'].map { |object| klass.construct_from(object) }
      else
        response
      end
    end
  end
end
