# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations', registrations: 'users/registrations',
                                    sessions: 'users/sessions', passwords: 'users/passwords' }
  resources :apartments
  resources :bookings
  resources :payments do
    collection do
      get 'thank_you'
    end
  end
  resources :inquiries
  resources :messages
  resources :rooms
  resources :invoices, only: %i[index show]
  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :apartments
    resources :settings, only: %i[index edit update]
    resources :users
    resources :apartment_types
    resources :apartments
    resources :subscriptions, only: %i[index new create]
    resources :invoices
    resources :bookings do
      put 'cancel_booking'
    end
    resources :rooms, only: %i[index show]
    get 'landlord_properties/:id', to: 'invoices#landlord_properties'
  end
  namespace :landlord do
    get '/dashboard', to: 'dashboard#index'
    resources :apartments
    resources :users, only: %i[edit update]
    resources :rooms
    resources :subscriptions, only: %i[index new create]
    resources :bookings, only: %i[index show]
    resources :invoices, only: %i[index show]
  end

  get '/new_invoice' => 'invoices#new', as: :add_invoice
  get '/card/new' => 'payments#new', as: :add_payment_method
  post '/card' => 'payments#create', as: :create_payment_method
  post '/subscription_payment' => 'payments#create_subscription_payment', as: :create_subscription_payment
  get 'sort_result', to: 'apartments#sort_result'
  get 'homes/index'
  post 'create_contact_us', to: 'homes#create_contact_us'
  get '/contact_us', to: 'homes#contact_us'
  get '/faq', to: 'homes#faq'
  get '/terms_and_conditions', to: 'homes#terms_and_conditions'
  get '/about_us', to: 'homes#about_us'
  get '/popup_forms', to: 'homes#popup_forms'
  get 'cities/:state', to: 'payments#cities'
  get 'render_login', to: 'inquiries#render_login_page'
  get 'invoice_details', to: 'invoices#invoice_details'
  get 'booking_instruction', to: 'bookings#booking_instruction'
  get '/invoice/:id/preview', to: 'invoices#preview', as: :preview
  get '/invoice/:id/download', to: 'invoices#download', as: :download
  get '/my_bookings', to: 'bookings#student_bookings', as: :my_bookings
  root 'homes#index'
end
