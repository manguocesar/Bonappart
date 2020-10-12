# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations', registrations: 'users/registrations' }
  resources :apartments
  resources :inquiries
  get 'sort_result', to: 'apartments#sort_result'
  get 'dashboard/index'
  get 'homes/index'
  root 'apartments#index'
end
