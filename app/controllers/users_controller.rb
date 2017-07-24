class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
  end

  def show
    respond_with(@user = User.find(params[:id]))
  end
end
