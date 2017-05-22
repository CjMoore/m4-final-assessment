Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index]
  resources :users, only: [:new, :create]

  get '/signup', to: 'users#signup', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
