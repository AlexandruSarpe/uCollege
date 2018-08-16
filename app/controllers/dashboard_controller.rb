# frozen_string_literal: true

# noinspection RailsParamDefResolve
class DashboardController < ApplicationController
  require 'signet/oauth_2/client'
  require 'google/apis/calendar_v3'
  require 'googleauth'
  before_action :authenticate_user!

  def index;
  end

#INUTILE
  # GAB
  def redirect
    #client.new li devo togliere poiche bisogna accedere sempre allo
    #stesso calendario 
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
  
  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    c_id=0;
    @calendar_list.items.each do |c| 
      c_id=c.id 
      break 
    end 
    #ritorna una lista di eventi 
    eventi=Google::Apis::CalendarV3::CalendarService.list_events(c_id)
    p eventi.items
    #risolto l'errore mi dovrebbe stampare su terminale gli eventi che ho inserito 
  end

  #in teoria non serve piu 
  def show_calendar
    #@meetings = Meetings.find_by_user_id(:user_id => current_user.id)
  end

  private
  def client_options
    {
      client_id: ENV['Google_Client_Id'],
      client_secret: ENV['Google_Client_Secret'],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
