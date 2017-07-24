module ControllerMacros
  def sign_in_user(admin = { admin: false })
    before do
      @user = create(:user, admin)
      @request.env['devise_mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end
end
