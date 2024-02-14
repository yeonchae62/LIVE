Rails.application.routes.draw do
  root 'main#index'
  resources :games
  #resources : sessions
  #resources :users, only: [:new, :create, :update, :destroy, :edit, :show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/login", to: "sessions#login"
  get "login", to: "main#create"
  get "/logout", to: "sessions#logout"
  get "/logout", to: "main#destroy"

  # Defines the root path route ("/")
  # root "posts#index"
end
