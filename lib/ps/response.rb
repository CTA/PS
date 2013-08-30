module PS 
  class Response < Base
    attr_accessor :is_success,:error_message,:sub_type,:ps_object,:total_items,:items_per_page,:current_page,:error_type

    CLASS = {
      "PsCustomer" => PS::Customer,
      "PsCustomerAccount" => PS::CustomerAccount,
      "PsPayment" => PS::Payment,
      "PsDefaultCustomerAccount" => PS::CustomerAccount
    }

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
    ## 'SubType' => String, <-- This tells us the subclass of PsObject
    ## 'TotalItems' => Int
    # }

    def initialize(params={})
      params.each { |k,v| instance_variable_set("@#{k.snake_case}", v) }
      successful?
      prepare_ps_object() if @ps_object
      self
    end

    private 
      def successful?
        raise RequestError, @error_message unless @is_success == true
      end

      def prepare_ps_object
        prepare_object_dates()
        if @ps_object.length == 1 then
          @ps_object = instantiate_object(@sub_type, snake_case_response()[0])
        else
          instantiate_object(@sub_type.split(","), snake_case_response())
        end
      end
      
      #Paysimple returns the attribute names in CamelCase, but the attributes use
      #snake_case within the code base. The method bellow converts the attribute 
      #names into snake_case so that they can be more easily dynamically assigned
      #to the appropriate class.
      def snake_case_response
        @ps_object.map { |ps_object| ps_object.snake_case_keys }
      end

      def prepare_object_dates
        @ps_object.each_with_index do |object, i|
          object.each do |key, value|
            if date?(value) then
              @ps_object[i][key] = parse_date(value)
            end
          end
        end
      end

      def instantiate_object(sub_type, object)
        case object
        when Array
          object.each_with_index do |object, i|
            @ps_object[i] = instantiate_object(sub_type[i % sub_type.length], object)
          end
        when Hash
          CLASS[sub_type].new(object)
        end
      end
  end
end
