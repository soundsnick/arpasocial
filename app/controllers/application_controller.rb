class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password,
                                                               :password_confirmation, :remember_me, :username, :name, :surname) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password,
                                                                      :password_confirmation, :current_password, :surname, :name, :username, :avatar) }
  end

  def after_sign_in_path_for(resource)
    user_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
