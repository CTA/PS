#require File.dirname(__FILE__)+"/psobject.rb"
module PS
  class Base
    ## options = {
    # :host,
    # :apikey
    # :userkey
    # :company_name
    #}

    def self.establish_connection(params={})
      api_klass = Module.const_get("PS::API::#{params[:format]}")
      $api = api_klass.new
      validate_and_assign(params)
    end

    def current_connection
      config = {
        :apikey => @api.apikey,
        :userkey => @api.userkey,
        :host => @api.host
      }
      puts config.inspect
    end

    private
      def validate_and_assign(params)
        Api.required_attributes.each do |key|
          if params.key?(key) then
            Api.send(key.to_s+"=", params[key])
          else
            raise "Missing required attribute: #{key}"
          end
        end
      end
  end
end
