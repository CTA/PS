module PS
  module State
    class << self
      YAML.load_file(File.dirname(__FILE__)+"/states.yml").each do |k,state|
        define_method state["abbreviation"].downcase.to_s do
          PS::States.const_get("#{state["abbreviation"].upcase}")
        end

        define_method state["name"].gsub(/ /, '_').downcase do
          PS::States.const_get("#{state["abbreviation"].upcase}")
        end
      end
    end
  end
end
