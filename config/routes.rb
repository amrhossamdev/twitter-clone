Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "account_activations/edit"
  get "sessions/new"
  root "static_pages#home"
  # Pages
  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "contact", to: "static_pages#contact"

  # Signup
  get "signup", to: "users#new"

  # Sessions
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users

  # Account Activations
  resources :account_activations, only: [ :edit ]
  # Password Reset
  resources :password_resets, only: [ :new, :create, :edit, :update ]
  # Microposts
  resources :microposts, only: [ :create, :destroy ]
end
