class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    sign_out current_user
    redirect_to root_path
  end

  protected

  def after_sign_up_path_for(_resource)
    new_user_session_path
  end

  def show
    # return unless params[:id] == 'sign_out'
    # sign_out current_user
    # redirect_to user_session_path
    sign_out current_user
    redirect_to root_path
  end

  def logout
    sign_out current_user
    redirect_to root_path
  end
end
