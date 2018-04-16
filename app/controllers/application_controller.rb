class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :logged_filter, except: [:index]
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def filter_admin!
    authenticate_user!
    redirect_to root_path, alert: "No tienes acceso" unless current_user.admin?
  end

  def logged_filter
    redirect_to root_path, alert: "No tienes acceso" unless user_signed_in?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
  end
end
