class TweetsController < ApplicationController
  def index
    if not is_logged_in
      redirect_to('/')
    end

    # Retrieve and display the last 20 tweets for the logged in user
    client = get_twitter_client(session['user_token'], session['user_secret'])
    @tweets = client.user_timeline(count=20, screen_name=session['screen_name'])
  end

  private

end
