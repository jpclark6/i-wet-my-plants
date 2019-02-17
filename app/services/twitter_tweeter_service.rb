class TwitterTweeterService
  def tweet
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API']
      config.consumer_secret     = ENV['TWITTER_SECRET_API']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

  def send_tweets
    tweeter = tweet
    binding.pry
    Plant.select("plants.*").where("EXTRACT(EPOCH FROM ((NOW()) - (last_watered))) > (frequency - 6) * 3600")
  end
end
