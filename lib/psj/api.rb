require 'httparty'
<<<<<<< HEAD:lib/paysimple/api.rb
class Api
=======
require 'json'
module PS
>>>>>>> Renamed some files:lib/psj/api.rb

  include HTTParty

  attr_accessor :apikey, :userkey, :host, :company_name

  def init
  end

  #actually prepare, and makes calls here...
  def call(method, params={})
    request - params.clone
    request[:apikey] = self.apikey
    request[:userkey] = self.userkey
    postdata = request.to_json
    headers={
      'Content-Type'=>"application/json;charset=utf-8",
      'Accept'=>"application/json",
      'User-Agent'=> self.company_name,
      'Content-Length'=>postdata.length.to_s
    }
    self.class.post("/#{method}",postdata, headers)
  end

  #From say Paysimple::Customer.find will tell call to call the search
  #functions on Paysimple's side, and parse ther esults.
  def method_missing(name, *args)
    call(name.to_s.gsub("_").downcase, *args)
  end

  #do some conversion for the ASP.net json date 
  #format http://msdn.microsoft.com/en-us/library/bb299886.aspx#intro_to_json_sidebarb 
  def json_date_format(date)
    "/Date(#{(date.to_i*1000)}-0700)/"     
  end                                            

  def json_date_parse(str)             
    Time.at(str[/([0-9]+)-([0-9]+)/,1].to_i/1000)
  end                                            
  
end
