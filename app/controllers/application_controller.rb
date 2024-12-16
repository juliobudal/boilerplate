class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  # Prevent CSRF attacks by raising an exception
  protect_from_forgery with: :exception

  # Authenticate user for all actions by default
  before_action :authenticate_user!
  before_action :set_locale

  # Configure permitted parameters for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Enforce authorization for all actions except Devise controllers
  # after_action :verify_authorized, except: [ :index ], unless: :devise_controller?
  # after_action :verify_policy_scoped, only: [ :index ], unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  private

  def set_locale
    I18n.locale = if current_user&.language.present?
                    current_user.language
                  else
                    extract_locale_from_accept_language_header || I18n.default_locale
                  end
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}-[A-Z]{2}/)&.first
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
