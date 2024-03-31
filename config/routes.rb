# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :games do
    collection do
      get 'cost'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  get '/login', to: 'main#login'
  get '/', to: 'main#index', as: :main_page

  # Defines the root path route ("/")
  # root "posts#index"
end
