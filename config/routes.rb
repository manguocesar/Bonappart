# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations', registrations: 'users/registrations' }
  resources :apartments
  resources :bookings
  resources :payments
  get '/card/new' => 'payments#new', as: :add_payment_method
  post '/card' => 'payments#create', as: :create_payment_method
  resources :inquiries
  get 'sort_result', to: 'apartments#sort_result'
  get 'dashboard/index'
  get 'homes/index'
  get 'cities/:state', to: 'payments#cities'
  root 'apartments#index'
end
