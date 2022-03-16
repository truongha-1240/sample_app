class PasswordResetsController < ApplicationController
  before_action :find_user_by_email, :valid_user,
                :check_expiration, only: %i(edit update)
  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".instruction"
      redirect_to root_url
    else
      flash.now[:danger] = t ".no_email"
      render :new
    end
  end

  def update
    if user_params[:password].blank?
      @user.errors.add :password, t(".error")
      render :edit
    elsif @user.update user_params
      @user.clear_password_reset
      log_in @user
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".cant_updated"
      render :edit
    end
  end

  private

  def find_user_by_email
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if @user&.authenticated?(:reset, params[:id]) && @user&.activated

    flash[:danger] = t "password_resets.invalid_link"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "password_resets.expired"
    redirect_to new_password_reset_url
  end
end
