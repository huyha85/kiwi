class CheckinsController < ApplicationController
  def index
    @users = User.all
    @user = User.where(id: user_id).first
    @checkins = user_id.blank? ? Checkin.all : Checkin.where(user_id: user_id)
  end

  private
  def user_id
    params[:user_id]
  end
end
