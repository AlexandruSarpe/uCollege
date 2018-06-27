# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :students
  devise_for :canteens
  devise_for :secretaries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :home
  root to: redirect('/home')
end
