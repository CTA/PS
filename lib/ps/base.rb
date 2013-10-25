module PS
  class Base 
    #hmm...
    extend Api
    include Api

    ## params.keys -> [
    # :apikey,
    # :userkey,
    # :company_name
    ##]
    def self.establish_connection(params={})
      connect(params.delete(:format))
      params[:env] ||= "development"
      validate_and_assign(params)
    end

    def self.current_connection
      puts connection_hash().inspect
    end
  end
end
