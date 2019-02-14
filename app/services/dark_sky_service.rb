class DarkSkyService

  def self.key
    ENV['DARK_SKY_API_KEY']
  end

  def self.conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def self.forecast(zip)
    geo_service = GoogleGeocodeService.new(zip)
    lat = geo_service.lat
    lng = geo_service.lng
    response = conn.get "/forecast/#{key}/#{lat},#{lng}"
    JSON.parse(response.body, symbolize_names: true)
  end

end
