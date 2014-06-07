class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :is_logged_in
  helper_method :get_twitter_client

  private

  def is_logged_in
    if current_user
      return TRUE
    else
      return FALSE
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_twitter_client(token, secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "6L2r6UCi5PEqaNs1GTo2e9yR0"
      config.consumer_secret     = "MHgiXSrOP6emV2z28bV5wR826exjKEwGl9jCRTSS7v5wt5snZC"
      config.access_token        = token
      config.access_token_secret = secret
    end
    return client
  end

end
