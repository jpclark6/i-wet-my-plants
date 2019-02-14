Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: "users#new"
  get '/login', to: "sessions#new"
  get '/auth/facebook/callback', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :garden, as: :plants
  get '/water_plant/:id', to: 'plants#water', as: 'water_plant'
end
