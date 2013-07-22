require 'set'
require 'active_model'
module PS
  class PsObject < Base

    attr_accessor :apikey, :userkey, :host, :company_name
    #@@permanent_attributes = [ :apikey, :userkey, :host, :company_name ].to_set

    def self.construct_from(ps_object)
      self.new(ps_object)
    end

    def inspect
      #some activerecord like inspect method... thing
    end

    def self.inherited(subclass)
#      if subclass == 'Base' then
#        [ 'apikey', 'userkey', 'host', 'company_name' ].each do |v|
#          self.send("#{v}=", Paysimple::Base.send(v))
#        end
#      end
    end

    def PsReferenceId
      self.id
    end

    def PsReferenceId=(value)
      self.id=value
    end

  end
end
