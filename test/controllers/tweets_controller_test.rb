require 'test_helper'

# Monkey patch the Twitter rest client
Twitter::REST::Client.class_eval do
  def initialize(*args)

  end

  def user_timeline(*args)
    return []
  end
end

class TweetsControllerTest < ActionController::TestCase
  test "not logged in" do
    session[:user_id] = nil
    get :index
    assert_response(302)
  end


  test "logged in" do

    info = {
        name: 'test',
        nickname: 'test',
    }
    credentials = {
        secret: '1234asdf',
        token: '1234asdf'
    }
    auth = {
        provider: 'twitter',
        uid: '1234',
        info: info,
        credentials: credentials
    }
    user = User.create_with_omniauth(auth)
    session[:user_id] = user.id

    get :index
    assert_response(200)
  end

end
