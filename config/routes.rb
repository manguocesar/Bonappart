# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations', registrations: 'users/registrations' }
  root 'apartments#index'
  get 'homes/index'
  resources :apartments
  get 'sort_result', to: 'apartments#sort_result'
  get 'dashboard/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
