module PS
  module Api
    class Json 
      include HTTParty
      attr_accessor :apikey, :userkey, :company_name, :env

      def initialize 
        @apikey = nil
        @userkey = nil
        @company_name = nil
        @env = "devlopment"
      end

      #### Some Basic fields returned by Paysimple
      # results = Api.post(#{request_details})
      # results = {
      ## 'd' => {
      ### '__type' => '',
      ### 'CurrentPage => Int,
      ### 'ErrorMessage => '',
      ### 'ErrorType' => Int,
      ### 'IsSuccess' => boolean,
      ### 'itemsPerPage' => Int,
      ### 'PsObject' => {
      #### ...
      ### },
      ### 'SubType' => '', <-- This tells us the subclass of PsObject
      ### 'TotalItems' => Int
      ## }
      #}
      def request(method, params={})
        results = self.class.post(request_url(method), options_hash(params))
        unless results.parsed_response['d']['IsSuccess'] then 
          raise results.parsed_response['d']['ErrorMessage'].inspect
        end
        format_response_dates(results.parsed_response['d'])
      end

      private
        #do some conversion for the ASP.net json dates
        def format_response_dates(response)
          response["PsObject"].each_with_index do |ps_object, i|
            ps_object.each do |key, value|
              if value.instance_of?(String) && value.include?("Date") then
                response["PsObject"][i][key] = parse_date(value)
              end
            end
          end
        end

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
