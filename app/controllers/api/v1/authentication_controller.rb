class Api::V1::AuthenticationController < Api::V1::BaseController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    p params.require(:email)
    p params.require(:password)

    user = User.find_by(email: params.require(:email))
    jwt_token = AuthenticationTokenService.encode(user.id)

    render json: { token: jwt_token }, status: :created
  end

  private

  def parameter_missing(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end
end
