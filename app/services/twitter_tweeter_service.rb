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
    Plant.plants_that_need_watering.each do |plant|
      tweet.update("#{} #{random_message(plant).sample}")
    end
  end

  def random_message(plant)
    []
  end
end
