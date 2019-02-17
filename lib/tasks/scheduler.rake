desc "This task is called by the Heroku scheduler add-on"
task :tweet_to_users => :environment do
  TwitterTweeterService.new.send_tweets
end