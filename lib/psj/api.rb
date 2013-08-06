require 'httparty'
require 'json'
module PS
  module Api 
    def connect(format)
      format ||= "JSON"
      begin
        require "psj/api/#{format.downcase}"
      rescue LoadError
        raise "#{format} is not a supported format"
      end
      $api = eval("PS::Api::#{format.downcase.capitalize}").new
    end

    def required_attributes
      $api.instance_variables.map do |instance_variable| 
        instance_variable.to_s[1..-1].to_sym
      end
    end

    def request(method, params={})
      results = $api.request(method, camel_case_request(params))
      if results["PsObject"] then
        Util.convert_to_ps_object(snake_case_response(results))
      else
        true
      end
    end

    #Paysimple expects the attribute names to be in CamelCase, but that isn't 
    #very ruby-esque; so, in an effort to be more ruby-esque, we define and 
    #work with the attributes in snake case. The method bellow converts from 
    #the ruby-esque snake case to PS' CamelCase.
    def camel_case_request(params)
      camel_params = {}
      params.each do |key, value|
        if value.class == Hash then
          camel_params[key] = {}
          value.each do |attribute, value|
            camel_params[key][attribute.to_s.split("_").collect { |x| x.capitalize }.join.to_sym] = value
          end
        else 
          camel_params[key] = value
        end
      end
      camel_params
    end

    #Paysimple returns the attribute names in CamelCase, but the attributes use
    #snake_case within the code base. The method bellow converts the attribute 
    #names into snake_case so that they can be more easily dynamically assigned
    #to the appropriate class.
    def snake_case_response(params)
      snake_case = []
      params.delete("PsObject").each do |object|
        snake_case_object = {}
        object.each do |attribute, value|
          snake_case_object[attribute.scan(/[A-Z][a-z0-9]+/).collect { |x| x.downcase }.join("_")] = value
        end
        snake_case << snake_case_object
      end
      params["PsObject"] = snake_case
      params
    end

    def env 
      $api.env
    end

    def host
      if env == "development" then
        "https://sandbox-api.paysimple.com/3.00/paysimpleapi"
      elsif env == "production" then
        "https://api.paysimple.com/3.00/paysimpleapi"
      end
    end
  end
end
