require 'httparty'
require 'json'
module PS
  module Api 
    def connect(format="JSON")
      begin
        require "psj/api/#{format}"
      rescue LoadError
        raise "#{format} is not a supported format"
      end
      $api = eval("PS::Api::#{format.upcase}").new
    end

    def required_attributes
      $api.instance_variables.map do |instance_variable| 
        instance_variable.to_s[1..-1].to_sym
      end
    end

    def request(method, params={}, header={})
      $api.request(method, params, header)
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
