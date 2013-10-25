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

    def to_s
      attrs = self.attributes.to_a.map { |k_v| 
        case k_v[1]
          when Fixnum
            "#{k_v[0]}: #{k_v[1]}" 
          when String || Time
            "#{k_v[0]}: '#{k_v[1]}'" unless k_v[1].empty?
        end

      }.delete_if(&:nil?).join(", ")
      "#<#{self.class} #{attrs}>"
    end

    private
      #this block will fail if more than one PS::Object is returned.
      def update_self
        Proc.new { |response|  set_attributes(response.ps_object) }
      end

      def self.instantiate_object
        Proc.new { |response| PS::Util.instantiate_ps_objects(response.ps_object) }
      end
  end
end
