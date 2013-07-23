module PS
  module Api
    class JSON
      include HTTParty
      attr_accessor :apikey, :userkey, :company_name, :env

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
      def request(method, params={}, headers={})
        request = params.clone
        request[:apikey] = @apikey
        request[:userkey] = @userkey
        postdata = request.to_json
        if headers.empty? then
          headers={
            'Content-Type'=>"application/json;charset=utf-8",
            'Accept'=>"application/json",
            'User-Agent'=> @company_name,
            'Content-Length'=>postdata.length.to_s
          }
        end
        results = self.class.post(
          "#{Api.host}/#{self.name}/#{method}",
          { :body => postdata, :headers => headers }
        )
        #raise results.inspect
        unless results.parsed_response['d']['IsSuccess'] then 
          raise results.parsed_response['d']['ErrorMessage'].inspect
        end
        results.parsed_response['d']
      end

    end
  end
end
