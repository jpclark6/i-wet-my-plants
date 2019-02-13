class DarkSkyService

  def self.key
    ENV['DARK_SKY_API_KEY']
  end

  def self.conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def self.forecast(lat_lon)
    conn.get "/forecast/#{key}/#{lat_lon}"
  end

end
