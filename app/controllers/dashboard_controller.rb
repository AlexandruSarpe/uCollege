# frozen_string_literal: true

# noinspection RailsParamDefResolve
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index;
  end


  # GAB
  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]
    response = client.fetch_access_token!
    session[:authorization] = response
    redirect_to calendars_path
  end



  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end

  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    c_id=0;
    @calendar_list.items.each do |c| 
      c_id=c.id
    end
  end

  def show_calendar
    #@meetings = Meetings.find_by_user_id(:user_id => current_user.id)
  end

end
