class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      "form"
    else
      "application"
    end
  end


  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
