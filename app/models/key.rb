class Key
  def initialize(key)
    @key = key
  end

  def self.create_water_key(plant)
    message = "#{plant.id}.#{1.hour.from_now}"
    key = Digest::SHA256.hexdigest "#{message}#{ENV['HARDWARE_SECRET_API']}"
    "#{message}.#{key}"
  end

  def valid?
    if plant_exists? && date_time_valid? && correct_secret?
      return true
    else
      return false
    end
  end

  def plant_id
    @key.split(".")[0].to_i
  end

  private

  def correct_secret?
    secret == expected_secret
  end

  def date_time_valid?
    date - DateTime.now > 0
  end

  def plant_exists?
    id = plant_id
    if id == 0
      return false
    end
    Plant.find(id)
  end

  def time_component
    @key.split(".")[1]
  end

  def date
    DateTime.parse(time_component)
  end

  def secret
    @key.split(".")[2]
  end

  def message
    "#{plant_id}.#{time_component}"
  end

  def expected_secret
    Digest::SHA256.hexdigest "#{message}#{ENV['HARDWARE_SECRET_API']}"
  end
end
