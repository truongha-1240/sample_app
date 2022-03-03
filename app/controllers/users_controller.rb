class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "noti.error.user_not_found"
    redirect_to root_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t "static_pages.home.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
