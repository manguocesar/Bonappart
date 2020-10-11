# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations', registrations: 'users/registrations' }
  root 'dashboard#index'
  get 'homes/index'
  resources :apartments
  resources :bookings
  resources :payments
  get '/card/new' => 'payments#new', as: :add_payment_method
  post '/card' => 'payments#create', as: :create_payment_method
  get 'sort_result', to: 'apartments#sort_result'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
