class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :send_info]

  def index
    @users = User.all
  end

  def show
    respond_with(:admin, @user)
  end

  def new
    respond_with(:admin, @user = User.new)
  end

  def create
    respond_with(:admin, @user = User.create(user_params))
  end

  def edit
    respond_with(:admin, @user)
  end

  def update
    @user.update(user_params)
    respond_with(:admin, @user)
  end

  def destroy
    respond_with(:admin, @user.destroy)
  end

  def send_info
    @user.create_and_send_pdf
    flash[:notice] = 'PDF file will be create and send via email later'
    redirect_to admin_user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio, :birth_date,
      :email, :password, :password_confirmation, :avatar)
  end
end
