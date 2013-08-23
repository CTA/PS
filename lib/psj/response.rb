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
    end

    def successful?
      #TODO write custom exceptions
      raise RequestError, @error_message  unless @is_success == true
    end
  end
end
