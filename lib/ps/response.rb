module PS 
  class Response
    attr_accessor :is_success,:error_message,:sub_type,:ps_object,:total_items,:items_per_page,:current_page,:error_type

    #### Some Basic fields returned by Paysimple
    # {
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
    # }
    def initialize(params={})
      params.each do |k,v|
        instance_variable_set("@#{k.snake_case}", v)
      end
      successful?
      $api.format_response_dates(self) #ask the format class how to format dates
      @ps_object &&= Util.convert_to_ps_object(snake_case_response(@ps_object)) 
      self
    end

    def successful?
      raise RequestError, @error_message unless @is_success == true
    end
    
    #Paysimple returns the attribute names in CamelCase, but the attributes use
    #snake_case within the code base. The method bellow converts the attribute 
    #names into snake_case so that they can be more easily dynamically assigned
    #to the appropriate class.
    def snake_case_response(params)
      params.ps_object.map do |ps_object|
        ps_object.snake_case_keys
      end
    end
  end
end
