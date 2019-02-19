class DarkSkyFacade

  def self.daily_forecast(zip)
    DarkSkyService.forecast(zip)[:daily]
  end

  def self.raining?(zip)
    rain = self.daily_forecast(zip)[:data].select do |time|
      time[:precipType] == 'rain'
    end
    if rain && rain.count > 0
      return true
    end
    false
  end

  def self.current_forecast(zip)
    DarkSkyService.forecast(zip)[:currently][:icon]
  end

  def self.current_temp(zip)
    DarkSkyService.forecast(zip)[:currently][:temperature]
  end

end
