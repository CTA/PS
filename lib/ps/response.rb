module PS 
  class Response < Base
    attr_accessor :is_success,:error_message,:sub_type,:ps_object,:total_items,:items_per_page,:current_page,:error_type,:exception_detail, :raw

    CLASS = {
      "PsCustomer" => PS::Customer,
      "PsCustomerAccount" => PS::CustomerAccount,
      "PsCreditCardAccount" => PS::CreditCardAccount,
      "PsAchAccount" => PS::AchAccount,
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
      self.raw = @ps_object if @ps_object
      self
    end

    def raw=(value)
      if value.length == 1 then
        @raw = value.first.snake_case_keys 
      else
        value.delete_if(&:nil?)
        @raw = value.map(&:snake_case_keys)
      end
    end

    def prepare_ps_object
      prepare_object_dates()
      if @ps_object.length == 1 then
        @ps_object = instantiate_object(snake_case_response().first)
      else
        instantiate_object(snake_case_response())
      end
      return @ps_object
    end

    private 
      def successful?
        raise RequestError, @exception_detail["InnerException"]["Message"] if @exception_detail
        raise RequestError, @error_message.join("; ") unless @is_success == true
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

      def instantiate_object(object)
        case object
        when Array
          object.each_with_index do |object, i|
            @ps_object[i] = instantiate_object(object)
          end
        when Hash
          klass_name = object.delete("__type").scan(/[a-zA-Z]+:/)[0][0..-2]
          CLASS[klass_name].new(object.symbolize_keys)
        end
      end
  end
end
