class Api::CheckinsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    resource = Checkin.toggle_checkin(checkin_email)
    render json: { timestamp: resource.created_at.to_i }
  end

  private
  def checkin_email
    params.require(:email)
  end
end
