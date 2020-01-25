class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = Users.find(params[:id])
  end
    
end