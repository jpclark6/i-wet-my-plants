desc "This task is called by the Heroku scheduler add-on"
task :tweet_to_users => :environment do
  TwitterTweeterService.new.send_tweets
end

task :get_current_precipitation => :environment do
  CurrentPrecipitationService.new.get_precipitation
end
