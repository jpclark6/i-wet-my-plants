class DarkSkyService

  def self.key
    ENV['DARK_SKY_API_KEY']
  end

  def self.conn(lat_lon)
  @conn =  Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
    thing = @conn.get "/forecast/#{key}/#{lat_lon}"
  end
end
