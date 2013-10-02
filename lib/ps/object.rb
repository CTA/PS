module PS
  class Object < Base
    attr_accessor :ps_reference_id

    def initialize(params = {})
      set_attributes(params)
    end

    def attributes
      attributes_hash = {}
      self.instance_variables.each do |v|
        attributes_hash[v[1..-1].to_sym] = self.send(v[1..-1])
      end
      attributes_hash
    end

    def set_attributes(params={})
      params.each do |k, v|
        next unless self.class.method_defined?(k)
        instance_variable_set("@#{k}", v)
      end
    end

    private
      #this block will fail if more than one PS::Object is returned.
      def update_self
        Proc.new { |response| 
          set_attributes(response.raw)
        }
      end

      def self.instantiate_object
        Proc.new { |response|
          response.prepare_ps_object
        }
      end
      
      def self.get_response_object 
        Proc.new { |response|
          response
        }
      end

      def get_response_object 
        Proc.new { |response|
          response
        }
      end
  end
end
