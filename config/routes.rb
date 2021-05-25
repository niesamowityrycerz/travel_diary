Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # omniauth_callbacks points to Users::OmniauthCallbacks

  resources :travel_notes, only: [:index, :create, :show, :destroy] 
end
