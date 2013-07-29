require 'httparty'
require 'json'
module PS
  module Api 
    def connect(format="JSON")
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
      Util.convert_to_ps_object($api.request(method, prepare_params(params)))
    end

    def prepare_params(params)
      camel_params = {}
      params.each do |key, value|
        camel_params[key.to_s.split("_").collect { |x| x.capitalize }.join.to_sym] = value
      end
      camel_params
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
