class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    return check_activated if @user&.authenticate params[:session][:password]

    flash.now[:danger] = t ".failed_login"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def check_activated
    remember_me = params[:session][:remember_me]
    if @user.activated
      log_in @user
      remember @user if remember_me == "1"
      redirect_back_or @user
    else
      message = t "noti.account_activation.message"
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
