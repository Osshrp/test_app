class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  layout 'admin'

  protected

  def check_admin
    redirect_to users_path,
      alert: 'You have no rights to access to that page' unless current_user.admin?
  end
end
