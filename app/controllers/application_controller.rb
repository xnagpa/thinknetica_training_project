class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#current_ability
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end 
  check_authorization unless: :devise_controller?

  private

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_out_path_for(_resource)
    session[:previous_url] || root_path
  end

  # def current_ability
  #   @current_ability ||= Ability.new(current_resource_owner)
  # end
end
