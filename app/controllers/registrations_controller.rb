class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :bio, :birth_date,
      :email, :password, :password_confirmation, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:name, :bio, :birth_date,
      :email, :password, :password_confirmation, :avatar)
  end
end
