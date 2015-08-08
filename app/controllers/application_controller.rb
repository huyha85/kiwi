class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    render json: { error: "Required parameter missing: #{parameter_missing_exception.param}" }, status: :bad_request
  end
end
