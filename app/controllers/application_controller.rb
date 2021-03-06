class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # Update for adding first name and surname to devise user model
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    registration_params = [:firstname, :surname, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end

  # Catching cancancan authorization messages
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # Catch deletion with association errors
  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to(:back, :alert => exception.message)
  end

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?


end
