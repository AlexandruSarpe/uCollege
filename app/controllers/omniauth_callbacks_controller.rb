# frozen_string_literal: true

class OmniauthCallbacksController < ApplicationController
  before_action :authenticate_user!, only: :google_oauth2_drive
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    authorize! :create, :Student, message: 'You can\'t create a new Student'
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      session[:user_id]=@user.id
      sign_in_and_redirect @user, event: :authentication
    else
      # Removing extra as it can overflow some session stores
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def google_oauth2_drive
    authorize! :create, :Drive_auth
    @auth = request.env['omniauth.auth']['credentials']
    Token.create(
      access_token: @auth['token'],
      refresh_token: @auth['refresh_token'],
      expires_at: Time.at(@auth['expires_at']).to_datetime
    )
    flash[:notice] = 'Drive account authenticated'
    redirect_to root_path
  end
end
