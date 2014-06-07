require 'twitter'

TWITTER_API_URL = 'http://api.twitter.com/1.1/'


class WelcomeController < ApplicationController
  def index
    current_user ||= User.find(session[:user_id]) if session[:user_id]
    x = 5
  end
end
