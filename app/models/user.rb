# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Creating student if they don't exist
    user ||= User.create(first_name: data['first_name'],
                         last_name: data['last_name'],
                         username: data['email'].split('@')[0],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20], type: 'Student')
    user
  end
end
