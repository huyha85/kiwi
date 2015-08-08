class Api::CheckinsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    resource = Checkin.toggle_checkin(checkin_email)
    if resource
      render json: { timestamp: resource.created_at.to_i }
    else
      render json: { error: 'Invalid user email' }, status: :bad_request
    end
  end

  private
  def checkin_email
    params.require(:email)
  end
end
