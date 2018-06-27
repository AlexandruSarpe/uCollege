# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # grouping all user models into user
  devise_group :user, contains: %i[student secretary canteen]
  # sanitizing additional parameters used in the user model
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name
                                                         username])
  end
end
