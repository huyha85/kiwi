class CheckinsController < ApplicationController
  def index
    @users = User.all
    @user = User.where(id: user_id).first
    all_checkins = user_id.blank? ? Checkin.all : Checkin.where(user_id: user_id)
    @checkins = all_checkins.page(permitted_params[:page].to_i)
  end

  private
  def permitted_params
    params.permit(:user_id, :page)
  end

  def permitted_params
    user_params[:user_id]
  end
end
