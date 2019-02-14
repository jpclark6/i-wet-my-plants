Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/register', to: "users#new"

  get '/dashboard', to: "gardens#index", as: 'dashboard'

  get '/dashboard/plants/:id/edit', to: 'plants#edit', as: 'edit_plant'
  post '/dashboard/plants/:id/water', to: 'plants#water', as: 'water_plant'

  get '/login', to: "sessions#new"
end
