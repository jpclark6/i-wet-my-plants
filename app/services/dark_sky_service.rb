class DarkSkyService
  def self.key
    ENV['DARK_SKY_API_KEY']
  end

  def self.forecast(zip)
    geo_service = GoogleGeocodeService.new(zip)
    get_json("/forecast/#{key}/#{geo_service.lat},#{geo_service.lng}")
  end

  private

  def self.get_json(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
