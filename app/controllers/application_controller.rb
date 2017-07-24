class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_users_path
    else
      user_path(current_user)
    end
  end
end
