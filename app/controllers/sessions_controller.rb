class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    remember_me = params[:session][:remember_me]
    if user&.authenticate params[:session][:password]
      log_in user
      remember user if remember_me == "1"
      redirect_back_or user
    else
      flash.now[:danger] = t ".failed_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
