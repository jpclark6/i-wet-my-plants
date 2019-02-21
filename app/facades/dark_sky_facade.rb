class DarkSkyFacade
  def self.current_forecast(zip)
    service(zip)[:currently][:icon]
  end

  def self.current_temp(zip)
    service(zip)[:currently][:temperature].round(1)
  end

  def self.current_precip_probability(zip)
    service(zip)[:currently][:precipProbability]
  end

  def self.raining?(zip)
    if self.current_precip_probability(zip) > 0.8
      return true
    else
      return false
    end
  end

  private

  def self.service(zip)
    DarkSkyService.forecast(zip)
  end
end
