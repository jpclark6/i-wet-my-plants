class TwitterTweeterService
  def tweet
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API']
      config.consumer_secret     = ENV['TWITTER_SECRET_API']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

  def send_tweet(message)
    tweet.update(message)
  end

  def send_tweets
    Plant.plants_that_need_watering.each do |plant|
      if plant.garden.tweet == true
        send_tweet(create_message(plant))
      end
    end
    "Success"
  end

  def create_message(plant)
    "@#{plant.garden.twitter_handle} #{random_message(plant).sample}"
  end

  def random_message(plant)
    ["Hey it's #{plant.name}, your #{plant.species}, please water me!",
    "...it's #{plant.name}, your #{plant.species}...need...water...",
    "I could sure use some water! Love, your #{plant.species}, #{plant.name}"]
  end
end
