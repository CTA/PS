module PS

  module Util

    def self.convert_to_ps_object(response)
      types = {
        "PsCustomer" => PS::Customer
      }
      case response
      when Hash
        klass = types[response['SubType']]
        klass.construct_from(response['PsObject'][0])
      when Array
        response.map { |x| convert_to_ps_object(x) }
      else
        response
      end
    end

  end

end
