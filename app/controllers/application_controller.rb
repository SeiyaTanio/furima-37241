class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, key: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, key: [:kanji_family_name])
    devise_parameter_sanitizer.permit(:sign_up, key: [:kanji_first_name])
    devise_parameter_sanitizer.permit(:sign_up, key: [:kana_family_name])
    devise_parameter_sanitizer.permit(:sign_up, key: [:kana_first_name])
    devise_parameter_sanitizer.permit(:sign_up, key: [:birth_date])
  end
end
