module PS
  module Api 
    ##
    # Establishes the connection to the appropriate paysimple v3 api.
    # Defaults to JSON
    def connect(format)
      format ||= "JSON"
      begin
        require "ps/api/#{format.downcase}"
      rescue LoadError
        raise ConnectionError, "#{format} is not a supported format"
      end
      $api = eval("PS::Api::#{format.downcase.capitalize}").new
    end

    def validate_and_assign(params)
      required_attributes().each do |key|
        if params.key?(key) then
          $api.instance_variable_set("@#{key.to_s}", params[key])
        else
          raise ArgumentError, "Missing required attribute: #{key}"
        end
      end
    end

    def required_attributes
      $api.instance_variables.map do |instance_variable| 
        instance_variable.to_s[1..-1].to_sym
      end
    end

    def connection_hash
      {
        :apikey => $api.apikey,
        :userkey => $api.userkey,
        :company_name => $api.company_name,
        :host => host()
      }
    end

    def request(method, params={}, &block)
      response = Response.new($api.request(method, camel_case_request(params)))
      block[response] if block
    end

    def env 
      $api.env
    end

    #TODO: make constants
    def host
      if env() == "development" then
        "https://sandbox-api.paysimple.com/3.00/paysimpleapi"
      elsif env() == "production" then
        "https://api.paysimple.com/3.00/paysimpleapi"
      end
    end
    
    #Paysimple expects the attribute names to be in CamelCase, but that isn't 
    #very ruby-esque; so, in an effort to be more ruby-esque, we define and 
    #work with the attributes in snake case. The method bellow converts from 
    #the ruby-esque snake case to PS' CamelCase.
    def camel_case_request(params)
      params.each { |key, value| value.camel_case_keys if value.class == Hash }
    end

    ##
    # returns the conditions for detecting if something is a date format for
    # the current format class
    def date?(object)
      $api.date?(object)
    end
    
    ##
    # How to parse dates for thi current format
    def parse_date(date)
      $api.parse_date(date)
    end
  end
end
