# encoding: utf-8
module PS
  module Api
    class Json 
      include HTTParty
      attr_reader :apikey, :userkey, :company_name, :env

      def initialize 
        @apikey = nil
        @userkey = nil
        @company_name = nil
        @env = "production"
      end

      def request(method, params={})
        post_response = self.class.post(request_url(method), options_hash(params)).parsed_response
        post_response['d'] || post_response
      end

      def date?(object)
        object.instance_of?(String) && object.include?("Date")
      end

      #do some conversion for the ASP.net json dates
      def parse_date(str)             
        Time.at(str[/([0-9]+)-([0-9]+)/,1].to_i/1000)
      end                                            

      private
        #TODO refactor
        def format_request_dates(request)
          request.each do |request_key,request_value|
            if request_value.instance_of? Hash then
              request_value.each do |obj_key, obj_value|
                if obj_value.instance_of? Time then
                  request[request_key][obj_key] = format_date(obj_value)
                end
              end
            elsif request_value.instance_of? Time then
              request[request_key] = format_date(request_value)
            end
          end
        end

        #format http://msdn.microsoft.com/en-us/library/bb299886.aspx#intro_to_json_sidebarb 
        def format_date(date)
          "/Date(#{(date.to_i*1000)}-0600)/"
        end                                            

        def options_hash(post_data)
          post_data[:apikey] = @apikey
          post_data[:userkey] = @userkey
          post_data = format_request_dates(post_data).to_json
          { 
            :body => post_data, 
            :headers => header(post_data.to_json.length.to_s)
          }
        end

        def request_url(method)
          "#{Base.host()}/#{name()}/#{method}"
        end

        def name 
          self.class.name.split('::').last.downcase
        end
        
        def header(content_length)
          {
            'Content-Type' => "application/json;charset=utf-8",
            'Accept' => "application/json",
            'User-Agent' => @company_name,
            'Content-Length' => content_length
          }
        end
    end
  end
end
