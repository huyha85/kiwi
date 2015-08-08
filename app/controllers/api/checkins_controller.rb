class Api::CheckinsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :verify_token

  def create
    resource = Checkin.toggle_checkin(checkin_params[:email])
    if resource
      render json: { timestamp: resource.created_at.to_i }
    else
      render json: { error: 'Invalid user email' }, status: :bad_request
    end
  end

  private
  def checkin_params
    [:email, :random, :token].each_with_object(params) do |key, obj|
      obj.require(key)
    end
  end

  def verify_token
    if server_token != checkin_params[:token]
      render json: { error: 'Unauthorized' }, status: :unauthorized
      return
    end
  end

  def server_token
    Digest::SHA256.hexdigest("#{request.path}#{checkin_params[:email]}#{checkin_params[:random]}")
  end
end
