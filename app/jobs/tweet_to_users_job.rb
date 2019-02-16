class TweetToUsersJob < ApplicationJob
  queue_as :default

  def send_tweets
    # Do something later
  end
end
