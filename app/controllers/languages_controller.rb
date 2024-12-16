class LanguagesController < ApplicationController
  def update
    if I18n.available_locales.include?(params[:locale].to_sym)
      if current_user
        current_user.update(language: params[:locale])
      end
      session[:locale] = params[:locale]
      I18n.locale = params[:locale]
    end
    
    redirect_back(fallback_location: root_path)
  end
end
