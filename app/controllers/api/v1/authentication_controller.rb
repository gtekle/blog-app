class Api::V1::AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    p auth_params

    render json: { token: '123' }, status: :created
  end

  private

  def auth_params
    params.require(:email)
    params.require(:password)
    params
  end

  def parameter_missing(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end
end
