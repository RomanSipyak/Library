class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:%i[username, email, password, password_confirmation,city_id, remember_me ])
    devise_parameter_sanitizer.permit(:sign_in, keys:%i[login, username, email, password, remember_me])
    devise_parameter_sanitizer.permit(:sign_out, keys:%i[username, email, password, password_confirmation, city_id, current_password])
  end
end
