module PS 
  class Response
    attr_accessor :is_success,:error_message,:sub_type,:ps_object,:total_items,:items_per_page,:current_page,:error_type

    #### Some Basic fields returned by Paysimple
    # {
    ## 'd' => {
    ### '__type' => String,
    ### 'CurrentPage => Int,
    ### 'ErrorMessage => String
    ### 'ErrorType' => Int,
    ### 'IsSuccess' => boolean,
    ### 'itemsPerPage' => Int,
    ### 'PsObject' => {
    #### ...
    ### },
    ### 'SubType' => String, <-- This tells us the subclass of PsObject
    ### 'TotalItems' => Int
    ## }
    # }
    def initialize(params={})
      params.each { |k,v| instance_variable_set("@#{k.snake_case}", v) }
      successful?
      format_response_dates() if @ps_object
      snake_case_response()
      @ps_object &&= Util.convert_to_ps_object(self) 
      self
    end

    def successful?
      raise RequestError, @error_message unless @is_success == true
    end
    
    #Paysimple returns the attribute names in CamelCase, but the attributes use
    #snake_case within the code base. The method bellow converts the attribute 
    #names into snake_case so that they can be more easily dynamically assigned
    #to the appropriate class.
    def snake_case_response
      @ps_object &&= @ps_object.map { |ps_object| ps_object.snake_case_keys }
    end

    def format_response_dates
      if $api.class.method_defined?(:format_response_dates) then
        $api.format_response_dates(self) #ask the format class how to format dates
      else 
        true
      end
    end
  end
end
