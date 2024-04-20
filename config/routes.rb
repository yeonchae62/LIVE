# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'main#index'

  get '/users/my_profile', to: 'users#show', as: :user_account_info

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  get '/login', to: 'main#login'
  get '/user_management', to: 'main#user_management'
  post '/change_role', to: 'main#change_role'
  get '/about', to: 'main#about'

  get '/', to: 'main#index', as: :main_page
  get '/games/cost', to: 'games#cost', as: 'games_with_cost'
  get '/games/dimensions', to: 'games#dimensions', as: 'games_with_dimensions'
  get '/games/publication_year', to: 'games#publication_year', as: 'games_with_publication_year'

  resources :saved_games, only: %i[index create]

  resources :games do
    collection do
      get 'cost'
      get 'publication_year'
      get 'dimensions'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
