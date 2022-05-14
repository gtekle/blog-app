class Api::V1::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::DecodeError, with: :not_authorized

  def not_found
    render json: 'Bad request!', errors: 'Not Found', status: 404
  end

  def not_authorized
    render json: 'Unauthorized!', errors: 'You have to sign in to access resource!', status: 401
  end

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    User.find(user_id)
  end
end
