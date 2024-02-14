Rails.application.routes.draw do
  root 'main#index'
  resources :games

  resources :users, only: [:new, :create, :update, :destroy, :edit, :show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get '/my_info', to: 'main#my_info'
  get '/categories', to: 'main#categories'
  get '/faq', to: 'main#faq'

  get '/login', to: 'main#login'
  get 'login', to: 'main#create'
  get '/logout', to: 'main#logout'
  get '/logout', to: 'main#destroy'

  # Defines the root path route ("/")
  # root "posts#index"
end
