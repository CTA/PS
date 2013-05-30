module Paysimple

  class Base

    ## options = {
    # :host,
    # :apikey
    # :userkey
    # :company_name
    # :env (optional)
    #}
    def initialize(options={})
      @api = Api.new
      #verify all required params are present.
      [:apikey, :userkey ].each do |x|
        if options.keys.include?(x) || options.keys.include?(x.to_s)
          @api.send("#{x}=", options[x])
        else
          #raise custom exception
        end
      end
      if options[:env] == 'production'
        @api.host =  "http://api.paysimple.com/3.00/paysimpleapi/json"
      else options[:env] == 'development'
        @api.host =  "http://sandbox-api.paysimple.com/3.00/paysimpleapi/json"
      end
    end

    def current_connection
      config = {
        :apikey => @api.apikey,
        :userkey => @api.userkey,
        :host => @api.host
      }
      puts config.inspect
    end

  end

end
