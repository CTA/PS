module PS
	class RecurringPaymentFilter < PsObject
		attr_accessor :active, :disabled, :paused, :expired, :suspended
    
    def active?
      self.active
    end

    def disabled?
      self.disabled
    end

    def paused?
      self.paused
    end

    def expired?
      self.expired
    end

    def suspended?
      self.suspended
    end
    
	end
end
