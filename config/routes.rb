# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations', registrations: 'users/registrations' }
  resources :apartments
  resources :bookings
  resources :payments
  get '/card/new' => 'payments#new', as: :add_payment_method
  post '/card' => 'payments#create', as: :create_payment_method
  resources :inquiries
  get 'sort_result', to: 'apartments#sort_result'
  get 'dashboard/index'
  get 'homes/index'
  post 'create_contact_us', to: 'homes#create_contact_us'
  get '/contact_us', to: 'homes#contact_us'
  get '/about_us', to: 'homes#about_us'
  get '/popup_forms', to: 'homes#popup_forms' 
  get 'cities/:state', to: 'payments#cities'
  get 'render_login', to: 'inquiries#render_login_page'
  root 'homes#index'
end
