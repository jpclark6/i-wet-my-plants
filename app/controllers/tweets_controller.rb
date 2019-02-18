class TweetsController < ApplicationController
  def start
    current_user.garden.update(tweet: true)
    flash[:updated] = 'Tweets have been turned on'
    redirect_to plants_path
  end

  def stop
    current_user.garden.update(tweet: false)
    flash[:updated] = 'Tweets have been turned off'
    redirect_to plants_path
  end
end