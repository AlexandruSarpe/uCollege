# frozen_string_literal: true

Rails.application.routes.draw do
  # devise users method
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }, path_prefix: 'new'
  devise_scope :user do
    get 'new/user/:id', to: 'users/registrations#show'
  end
  # making /dashboard the root for authenticated users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  # root for non authenticated users
  root 'home#index'

  # users managing methods used by secretaries
  resources :users, only: %i[index show edit destroy update]

  # courses managing methods
  get '/courses/enrollable', to: 'courses#enrollable'
  resources :courses do
    resources :materials, only: %i[index show destroy new create]
    resources :enrollments, only: :index
    get 'enrollment', to: 'enrollments#show'
    post 'enrollment/:id', to: 'enrollments#add'
    delete 'enrollment/:id', to: 'enrollments#destroy'
  end
  get 'courses/student/:id', to: 'courses#enrolled'

  get '/auth/google_oauth2/callback', to: 'omniauth_callbacks#google_oauth2'
  get 'auth/google_oauth2_drive/callback', to: 'omniauth_callbacks#google_oauth2_drive'
end
