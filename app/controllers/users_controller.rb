class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_approved!
  
  def index   
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
end
