class Key
  def self.valid?(key)
    plant_id = find_id(key).to_i
    date = DateTime.parse(key.split(".")[1])
    secret = key.split(".")[2]
    message = "#{key.split(".")[0]}.#{key.split(".")[1]}"
    expected_secret = Digest::SHA256.hexdigest "#{message}#{ENV['HARDWARE_SECRET_API']}"

    if Plant.find(plant_id) == nil
      return false
    end

    if date - DateTime.now < 0
      return false
    end

    if secret != expected_secret
      return false
    end

    true
  end

  def self.find_id(key)
    key.split(".")[0]
  end
end