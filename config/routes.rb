Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index, :create, :edit, :update]
  resources :users, only: [:new, :create] do
    # resources :links, only: [:create]
  end

  get '/signup', to: 'users#signup', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update, :index]
      get '/recent_links', to: 'links#recent_links', as: 'recent_links'
    end
  end
end
