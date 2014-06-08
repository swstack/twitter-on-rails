class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:screen_name] = auth[:info][:nickname]
    session[:user_id] = user.id
    session[:user_token] = auth['credentials']['token']
    session[:user_secret] = auth['credentials']['secret']
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:screen_name] = nil
    session[:user_id] = nil
    session[:user_token] = nil
    session[:user_secret] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
