Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'devise/confirmations' }
  get 'homes/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
