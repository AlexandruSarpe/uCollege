module OmniAuth::Strategies
  class GoogleOauth2Drive < GoogleOauth2
    option :name, 'google_oauth2_drive'
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['Google_Client_Id'],
           ENV['Google_Client_Secret'], scope: 'profile, email', access_type: 'online'

  provider :google_oauth2_drive, ENV['Google_Client_Id'],
           ENV['Google_Client_Secret'], scope: 'email, https://www.googleapis.com/auth/drive', access_type:'offline'
end
