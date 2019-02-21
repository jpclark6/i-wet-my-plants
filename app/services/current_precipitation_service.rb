class CurrentPrecipitationService
  def get_precipitation
    Garden.all.each do |garden|
      if DarkSkyFacade.raining?(garden.zip_code)
        garden.reset_watering
      end
    end
  end
end
