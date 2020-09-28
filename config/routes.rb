# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations' }
  root 'dashboard#index'
  get 'homes/index'
  resources :apartments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
