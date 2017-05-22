Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index]

  get '/signup', to: 'users#signup', as: 'signup'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
