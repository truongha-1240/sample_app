class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user_by_id, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "noti.account_activation.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @pagy, @users = pagy(User.all)
  end

  def show
    @pagy, @microposts = pagy @user.microposts
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "users.edit.updated_sucess"
      redirect_to @user
    else
      flash.now[:error] = t "users.edit.updated_faild"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.destroy_success"
    else
      flash[:error] = t "users.destroy.destroy_fail"
    end
    redirect_to users_url
  end

  private

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "noti.error.user_not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "noti.error.user_not_permission"
    redirect_to root_url
  end
end
