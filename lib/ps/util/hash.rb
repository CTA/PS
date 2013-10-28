class Hash
  def camel_case_keys
    camel_case_hash = {}
    self.each do |key, value|
      camel_case_hash[key.to_s.to_camel_case] = value
    end
    self.replace(camel_case_hash)
  end

  def snake_case_keys
    snake_case_hash = {}
    self.each do |key, value|
      snake_case_hash[key.to_s.to_snake_case] = value
    end
    self.replace(snake_case_hash)
  end
end
