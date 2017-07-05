class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:first_language]
    devise_parameter_sanitizer.permit :edit, keys: [:first_language, :second_language, :third_language, :name]
  end
  
  def set_locale
    I18n.locale = user_language || I18n.default_locale
  end
  
  def user_language
    if current_user != nil then
      case current_user.first_language
      when "日本語"
        return :ja
      when "English"
        return :en
      else
        return I18n.default_locale
      end
    else
      I18n.default_locale
    end
  end
  
end
