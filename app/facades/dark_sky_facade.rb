class DarkSkyFacade

  def self.daily_forecast(lat_lon)
    DarkSkyService.forecast(lat_lon)[:daily]
  end

  def self.raining?(lat_lon)
    rain = []
    self.daily_forecast(lat_lon)[:data].map do |time|
      if time[:precipType] == 'rain'
        rain << time[:precipType]
      end
    end
      if rain.count > 0
        true
      end
  end
end
