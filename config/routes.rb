# frozen_string_literal: true

Rails.application.routes.draw do
  # devise users method
  devise_for :users, path: 'users', controllers: {
      sessions: 'users/sessions', registrations: 'users/registrations'
  }, path_prefix: 'new'
  # making /dashboard the root for authenticated users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
    resources :books
    post "/books/:id/borrow", to: 'books#borrow' , as: "borrow_book"
    post "/books/:id/returnbook", to: 'books#returnbook', as: "returnbook_book"


  end
  # root for non authenticated users
  root 'home#index'
  # users managing methods
  resources :users, only: %i[index show edit destroy update]

end
