module PS
  module Api
    class JSON 
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
        results = self.class.post(
          request_url(method),
          options_hash(params)
        )
        raise results.inspect
        unless results.parsed_response['d']['IsSuccess'] then 
          raise results.parsed_response['d']['ErrorMessage'].inspect
        end
        results.parsed_response['d']
      end

      private
        def options_hash(post_data)
          post_data[:apikey] = @apikey
          post_data[:userkey] = @userkey
          { 
          :body => post_data.to_json, 
          :header => header(post_data.length.to_s)
          }
        end

        def request_url(method)
          "#{Base.host}/#{name()}/#{method}"
        end

        def name 
          self.class.to_s
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
