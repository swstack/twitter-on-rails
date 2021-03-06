class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.name = auth[:info][:name]
      user.screen_name = auth[:info][:nickname]
      user.api_secret = auth[:credentials][:secret]
      user.api_token = auth[:credentials][:token]
    end
  end
end
