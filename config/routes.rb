# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations', registrations: 'users/registrations' }
  resources :apartments
  resources :bookings
  resources :payments
  resources :inquiries
  resources :subscriptions, only: %i[new create]
  namespace :admin do
    resources :apartment_types
  end
  get '/card/new' => 'payments#new', as: :add_payment_method
  post '/card' => 'payments#create', as: :create_payment_method
  get 'sort_result', to: 'apartments#sort_result'
  get 'dashboard/index'
  get 'homes/index'
  get 'cities/:state', to: 'payments#cities'
  get 'render_login', to: 'inquiries#render_login_page'
  root 'apartments#index'
end
