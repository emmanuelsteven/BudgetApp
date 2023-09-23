class SplashController < ApplicationController
  def index
    @user = User.new # This is just an example, you can initialize the user object as needed.
  end
end
