# frozen_string_literal: true

Rails.application.routes.draw do
  # devise users method
  devise_for :users, path: 'users', controllers: {
      sessions: 'users/sessions', registrations: 'users/registrations'
  }, path_prefix: 'new'
  # making /dashboard the root for authenticated users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  # root for non authenticated users
  root 'home#index'

  # users managing methods
  resources :books,:users, only: %i[index show edit destroy update]
end
