class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[email name photo bio password password_confirmation]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[email name photo bio password password_confirmation]
    )
  end
end
