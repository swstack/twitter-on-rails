class MutualfollowersController < ApplicationController

  #-----------------------------------------------------------------------------
  # Public (routes)
  #-----------------------------------------------------------------------------
  def index
    if not is_logged_in
      redirect_to('/')
    end

    @user_screen_name = session[:screen_name]
  end

  def find
    if not is_logged_in
      redirect_to('/')
    end

    response = Hash.new
    screen_name = params[:screen_name]
    if screen_name != ''

      # find logged in users followers
      user_followers = _make_users_hash(_get_followers_for_screen_name(session[:screen_name]))

      # find followers for target user
      target_followers = _make_users_hash(_get_followers_for_screen_name(screen_name))

      # find mutual followers
      mutual_followers = _intersect_users(user_followers, target_followers)

      response[:user_followers] = user_followers
      response[:target_followers] = target_followers
      response[:mutual_followers] = mutual_followers

    end

    render json: response
  end

  #-----------------------------------------------------------------------------
  # Private Methods
  #-----------------------------------------------------------------------------
  private

  def _make_users_hash(users_array)
    # This is a function that takes an array of `Twitter.User` objects and
    # returns a hash of key/value pairs in the form of:
    #         {
    #              <uid>: {
    #                       screen_name: <screen_name>,
    #                       profile_url: <profile_url>,
    #                     }
    #         }

    hashed_users = Hash.new
    users_array.each { |user|
      hashed_user = Hash.new
      hashed_user[:screen_name] = user.attrs[:screen_name]
      hashed_user[:profile_url] = 'https://twitter.com/%s' % user.attrs[:screen_name]
      hashed_users[user.attrs[:id_str]] = hashed_user
    }
    return hashed_users
  end

  def _intersect_users(users_hash_1, users_hash_2)
    # Given two users hashes (see: _make_users_hash) return a similar
    # hash of their intersection based on the keys

    keys_intersection = users_hash_1.keys & users_hash_2.keys
    intersection = Hash.new
    keys_intersection.each { |key|
      intersection[key] = users_hash_1[key]
    }
    return intersection
  end

  def _get_followers_for_screen_name(screen_name)
    client = get_twitter_client(session['user_token'], session['user_secret'])
    followers = []
    following_ids = client.friend_ids(screen_name=screen_name)
    return client.users(user_id=following_ids.attrs[:ids])
  end

end
