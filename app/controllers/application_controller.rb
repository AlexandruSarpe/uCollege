# frozen_string_literal: true

class ApplicationController < ActionController::Base
  alias devise_current_user current_user
  alias devise_user_signed_in? user_signed_in?

  # if the user can't perform the action go back to the dashboard
  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

  private

  # rewriting devise current_user and user_signed_in to support both Devise and independent omniauth
  def current_user
    if devise_current_user.nil?
      return User.find(session[:user_id]) unless session[:user_id].nil?
    else
      devise_current_user
    end
  end

  def user_signed_in?
    devise_user_signed_in? || !session[:user_id].nil?
  end
end
