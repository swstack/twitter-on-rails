Rails.application.routes.draw do
  root to: 'welcome#index'
  match "/auth/:provider/callback" => "sessions#create", via: :get
  match "/signout" => "sessions#destroy", :as => :signout, via: :get
end
