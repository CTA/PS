require 'httparty'
require 'json'
module PS

  module Api 
    class << self 
      def request(method, params={}, headers={})
        $api.request(method, params, headers)
      end

      def self.current_connection
        config = {
          :apikey => $api.apikey,
          :userkey => $api.userkey,
          :host => $api.host
        }
        puts config.inspect
      end

      def required_attributes
        $api.class.instance_methods.grep(/\w=$/).map do |method| 
          method.to_s.chop.to_sym
        end
      end

      $api.instance_methods.grep(/\w=$/).each do |method_name|
        define_method method_name do |value|
          $api.send(method_name, value)
        end
      end
    end
  end
end
