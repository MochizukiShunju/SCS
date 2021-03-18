class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    notifications_path
  end

  def after_sign_out_path_for(resource)
    homes_top_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:department])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_code])
  end
end
