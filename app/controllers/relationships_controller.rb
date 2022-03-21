class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user_by_id, only: :create
  before_action :find_followed_by_id, only: :destroy
  def create
    current_user.follow @user

    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user

    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def find_user_by_id
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "noti.error.user_not_found"
    redirect_to root_path
  end

  def find_followed_by_id
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t "noti.error.user_not_found"
    redirect_to root_path
  end
end
