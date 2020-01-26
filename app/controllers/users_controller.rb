class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.includes(:profile)
  end
  
  def show
    @user = Users.find(params[:id])
  end
    
end