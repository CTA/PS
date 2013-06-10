require 'psj/api'
require 'psj/customer'
require 'psj/base'
require 'psj/psobject'
require 'psj/util'

module PS

  #do some conversion for the ASP.net json date 
  #format http://msdn.microsoft.com/en-us/library/bb299886.aspx#intro_to_json_sidebarb 
  def self.json_date_format(date)
    "/Date(#{(date.to_i*1000)}-0700)/"     
  end                                            

  def self.json_date_parse(str)             
    Time.at(str[/([0-9]+)-([0-9]+)/,1].to_i/1000)
  end                                            


  
end
