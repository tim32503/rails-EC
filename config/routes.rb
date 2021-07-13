Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }
  resource :shop
  resources :products
  resources :facebook, only: [:index, :create]
  
  root "pages#index"
end
