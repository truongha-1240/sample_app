class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t ".flash_success"
      redirect_to root_url
    else
      flash.now[:error] = t ".flash_error"
      @pagy, @feed_items = pagy(current_user.feed)
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".success_noti"
    else
      flash[:danger] = t ".danger_noti"
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::ATTR_CHANGE
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "microposts.noti.check_user_danger"
    redirect_to request.referer || root_url
  end
end
