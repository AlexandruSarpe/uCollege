# frozen_string_literal: true

require 'net/http'
require 'json'

class Token < ApplicationRecord
  validates_presence_of :access_token
  validates_presence_of :refresh_token
  validates_presence_of :expires_at
  def to_params
    { 'refresh_token' => refresh_token,
      'client_id' => ENV['Google_Client_Id'],
      'client_secret' => ENV['Google_Client_Secret'],
      'grant_type' => 'refresh_token' }
  end

  def request_token_from_google
    url = URI('https://accounts.google.com/o/oauth2/token')
    Net::HTTP.post_form(url, to_params)
  end

  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    update_attributes(
      access_token: data['access_token'],
      expires_at: Time.now + data['expires_in'].to_i.seconds
    )
  end

  def expired?
    expires_at < Time.now
  end

  def fresh_token
    refresh! if expired?
    access_token
  end
end
