Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: "users#new"
  get '/login', to: "sessions#new"
  get '/auth/facebook/callback', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :plants
  resources :gardens, only: [:new, :create]

  patch '/water_plant/:id', to: 'plants#water', as: 'water_plant'
  patch '/water_plants', to: 'plants#water_all', as: 'water_all_plants'
end
