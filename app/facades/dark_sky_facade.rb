class DarkSkyFacade

  def self.current_forecast(zip)
    DarkSkyService.forecast(zip)[:currently][:icon]
  end

  def self.current_temp(zip)
    DarkSkyService.forecast(zip)[:currently][:temperature].round(1)
  end

  def self.current_precip_probability(zip)
    DarkSkyService.forecast(zip)[:currently][:precipProbability]
  end

  def self.raining?(zip)
    if self.current_precip_probability(zip) > 0.8
      return true
    else
      return false
    end
  end
end
