#require File.dirname(__FILE__)+"/psobject.rb"
module PS
  class Base 

    include Api
    ## options = {
    # :host,
    # :apikey
    # :userkey
    # :company_name
    #}

    def self.establish_connection(params={})
      connect(params.delete(:format))
      if params[:env].nil? then params[:env] = "development" end
      validate_and_assign(params)
    end

    def current_connection
      config = {
        :apikey => $api.apikey,
        :userkey => $api.userkey,
        :host => host()
      }
      puts config.inspect
    end

    private
      def self.validate_and_assign(params)
        required_attributes().each do |key|
          if params.key?(key) then
            $api.send(key.to_s+"=", params[key])
          else
            raise "Missing required attribute: #{key}"
          end
        end
      end
  end
end
