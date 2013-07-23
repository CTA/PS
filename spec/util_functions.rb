def json_connection_config
  YAML.load_file(File.dirname(__FILE__)+"/../spec_config/config.yml")[:json]
end
