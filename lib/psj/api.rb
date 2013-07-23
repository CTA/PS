require 'httparty'
require 'json'
module PS
  module Api 

    class << self 
      def connect(format)
        begin
          require "psj/api/#{format}"
        rescue LoadError
          raise "#{format} is not a supported format"
        end
        $api = eval("PS::Api::#{format.upcase}").new
      end

      def required_attributes
        $api.class.instance_methods.grep(/\w=$/).map do |method| 
          method.to_s.chop.to_sym
        end
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
end
