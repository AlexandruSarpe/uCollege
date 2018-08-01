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
  resources :books
  post '/books/:id/borrow', to: 'books#borrow', as: 'borrow_book'
  post '/books/:id/returnbook', to: 'books#returnbook', as: 'returnbook_book'
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
  get 'auth/google_oauth2_drive/callback', to: 'omniauth_callbacks#google_oauth2_drive'

  # Menus
  get '/menus/indexAll', to: 'menus#indexAll'
  get '/reservations', to: 'reservations#index'
  resources :menus do
    # Reservations
    get '/reservations/newGuest', to: 'reservations#newGuest'
    resources :reservations
  end

  # Forms
  resources :forms do
    get 'showResult', to: 'forms#showResult'
  end

  # root for non authenticated users
  root 'home#index'
  resources :menus, only: [:show]
  get '/auth/google_oauth2/callback', to: 'omniauth_callbacks#google_oauth2'
  get 'auth/failure', to: 'omniauth_callbacks#failure'
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
