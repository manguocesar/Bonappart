# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations', registrations: 'users/registrations' }
  resources :apartments
  get 'homes/index'
  get 'sort_result', to: 'apartments#sort_result'
  get 'dashboard/index'
  root 'apartments#index'
end
