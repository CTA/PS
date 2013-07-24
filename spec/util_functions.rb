def formatted_connection_config(format)
  config = YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")
  config[:format] = format
  config
end

def formatless_connection_config
  YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")
end
