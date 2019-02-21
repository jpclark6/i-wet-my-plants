Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: "users#new"
  get '/login', to: "sessions#new"
  get '/auth/facebook/callback', to: "sessions#create"
  get '/guest', to: "sessions#guest"
  delete '/logout', to: "sessions#destroy"

  resources :plants
  resources :gardens, only: [:new, :create]

  patch '/water_plant/:id', to: 'plants#water', as: 'water_plant'
  patch '/water_plants', to: 'plants#water_all', as: 'water_all_plants'
  patch '/stop_tweets', to: 'tweets#stop', as: 'stop_tweets'
  patch '/start_tweets', to: 'tweets#start', as: 'start_tweets'

  namespace :api do
    namespace :v1 do
      get '/', to: 'welcome#index'
      get '/plants', to: 'plants#index'
      post '/plants', to: 'plants#water'
    end
  end
end
