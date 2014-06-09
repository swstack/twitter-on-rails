class MutualfollowersController < ApplicationController
  def index
    # Make sure the user is logged in before rendering this page
    if not is_logged_in
      redirect_to('/')
    end

    @user_followers = _get_followers_for_screen_name(session[:screen_name])
    @user_screen_name = session[:screen_name]
  end

  def find
    screen_name = params[:screen_name]
    if screen_name != ''
      followers = _get_followers_for_screen_name(screen_name)
      @target_followers = followers
      @mutual_followers = @user_followers & @target_followers
    end

    render json: @product
  end

  private

  def _get_followers_for_screen_name(screen_name)
    num_users = 100  # TODO: Handle more than 100 users
    client = get_twitter_client(session['user_token'], session['user_secret'])
    followers = []
    following_ids = client.friend_ids(count=num_users, screen_name=screen_name)
    return client.users(user_id=following_ids.attrs[:ids])
  end
end
