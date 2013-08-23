module PS
  module Api
    class Json 
      include HTTParty
      attr_accessor :apikey, :userkey, :company_name, :env

      def initialize 
        @apikey = nil
        @userkey = nil
        @company_name = nil
        @env = "development"
      end

      def request(method, params={})
        PS::Response.new(
          self.class.post(request_url(method), options_hash(params)).parsed_response['d']
        )
      end

      #do some conversion for the ASP.net json dates
      def format_response_dates(response)
        if response.ps_object then
          response.ps_object.each_with_index do |ps_object, i|
            ps_object.each do |key, value|
              if value.instance_of?(String) && value.include?("Date") then
                response.ps_object[i][key] = parse_date(value)
              end
            end
          end
        end
        response
      end
      private
        def format_request_dates(request)
          request.each do |key, value|
            if value.instance_of? Time then
              request[key] = format_date(value)
            end
          end
        end

        #format http://msdn.microsoft.com/en-us/library/bb299886.aspx#intro_to_json_sidebarb 
        def format_date(date)
          "/Date(#{(date.to_i*1000)}-0700)/"     
        end                                            

        def parse_date(str)             
          Time.at(str[/([0-9]+)-([0-9]+)/,1].to_i/1000)
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
          "#{Base.host}/#{name()}/#{method}"
        end

        def name 
          self.class.name.split('::').last.downcase
        end
        
        def header(content_length)
          {
            'Content-Type'=>"application/json;charset=utf-8",
            'Accept'=>"application/json",
            'User-Agent'=> @company_name,
            'Content-Length'=> content_length
          }
        end

    end
  end
end
