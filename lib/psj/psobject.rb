module PS
  class PsObject < Base

    def initialize(params = {})
      params.each do |k, v|
        next unless self.class.method_defined?(k)
        send("#{k}=", v)
      end
    end

    def self.construct_from(ps_object)
      self.new(ps_object)
    end

    def inspect
    end

    def PsReferenceId
      self.id
    end

    def PsReferenceId=(value)
      self.id=value
    end

    def attributes
      attributes_hash = {}
      self.instance_variables.each do |v|
        attributes_hash[v[1..-1].to_sym] = self.send(v[1..-1])
      end
      attributes_hash
    end
  end
end
