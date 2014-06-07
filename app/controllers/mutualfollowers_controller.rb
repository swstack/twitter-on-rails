class MutualfollowersController < ApplicationController
  def index
    # Make sure the user is logged in before rendering this page
    if not is_logged_in
      redirect_to('/')
    end
  end
end
