#require File.dirname(__FILE__)+"/psobject.rb"
module PS
  class Base 
    extend Util
    #hmm...
    extend Api
    include Api
    ## params.keys = {
    # :host,
    # :apikey
    # :userkey
    # :company_name
    #}

    def self.establish_connection(params={})
      connect(params.delete(:format))
      params[:env] ||= "development"
      validate_and_assign(params)
    end

    def self.current_connection
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
            $api.instance_variable_set("@#{key.to_s}", params[key])
          else
            raise ArgumentError, "Missing required attribute: #{key}"
          end
        end
      end
  end
end
