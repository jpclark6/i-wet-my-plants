class DarkSkyService
  def self.conn(lat_lon)
    key =  ENV['DARK_SKY_API_KEY']
    @conn = Faraday.get  "https://api.darksky.net/forecast/#{key}/42.3601,-71.0589"
  end
end
