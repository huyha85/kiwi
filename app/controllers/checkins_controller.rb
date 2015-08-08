class CheckinsController < ApplicationController
  def index
    @tab = 'data'
    @user = User.where(id: user_id).first
    @checkins = collection.page(permitted_params[:page].to_i).per(CHECKINS_PER_PAGE)
    @graph_data = collection.limit(NUMBER_OF_LAST_CHECKINS)
  end

  private
  def permitted_params
    params.permit(:user_id, :page)
  end

  def user_id
    permitted_params[:user_id]
  end

  def collection
    user_id.blank? ? Checkin.all : Checkin.where(user_id: user_id)
  end
end
