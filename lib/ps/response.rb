module PS 
  class Response < Base
    attr_accessor :is_success,:error_message,:sub_type,:ps_object,:total_items,:items_per_page,:current_page,:error_type,:exception_detail

    #### Some Basic fields returned by Paysimple
    # {
    ## '__type' => String,
    ## 'CurrentPage => Int,
    ## 'ErrorMessage => String
    ## 'ErrorType' => Int,
    ## 'IsSuccess' => boolean,
    ## 'itemsPerPage' => Int,
    ## 'PsObject' => [
    ### { ... },
    ### ...
    ## ],
    ## 'SubType' => String, 
    ## 'TotalItems' => Int
    # }

    ## God this is terribly worded...
    # After the format classes; JSON, XML, SOAP, etc; get a response from 
    # Paysimple, the response should be parsed from the respective format into
    # a ruby hash. That hash is then passed here, and the response is setup. 
    # example: 
    #   post_response = HTTParty.post("https://api.paysimple.com/3.00/paysimpleapi", options_hash(params))
    #   parsed_response = post_response.parsed_response['d'] #the 'd' key is specific to the json format
    #   Response.new(parsed_response) 
    def initialize(params={})
      params.each { |k,v| instance_variable_set("@#{k.to_snake_case}", v) }
      successful_request?()
      @ps_object ||= [] 
      parse_ps_object()
      self
    end

    private 
      ##
      # Checks for errors in the PsResponse.
      def successful_request?
        raise RequestError, @exception_detail["InnerException"]["Message"] if @exception_detail
        raise RequestError, @error_message.join("; ") unless @is_success == true
      end

      def parse_ps_object()
        snake_case_ps_object_keys()
        parse_object_dates()
        if @ps_object.length == 1 then
          @ps_object = @ps_object.first
        end
      end

      ##
      # Paysimple returns the attribute names in CamelCase, but the attributes use
      # snake_case within the code base. The method bellow converts the attribute 
      # names into snake_case so that they can be more easily dynamically assigned
      # to the appropriate class.
      def snake_case_ps_object_keys
        # this line might seem a bit odd, but it is necessary because there
        # are two paysimple methods that, depending on the context, will 
        # return @ps_object where one of the elements is an instance of 
        # NilClass.
        @ps_object.delete_if(&:nil?)
        @ps_object.map!(&:snake_case_keys)
      end

      ##
      # parses date fields into a rubyesque format.
      def parse_object_dates
        @ps_object.each_with_index do |object, i|
          object.each do |key, value|
            # here we are asking the format class if the value is a date in its
            # format. For Example, the json format class returns dates in the 
            # following format: "/Date(1248908403000-0600)/"
            if date?(value) then
              # if so, then we now ask the format class how to parse that date.
              @ps_object[i][key] = parse_date(value)
            end
          end
        end
      end
  end
end
