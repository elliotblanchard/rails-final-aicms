Rails.application.routes.draw do
  root "sessions#index"
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/auth/google_oauth2/callback' => 'sessions#googleauth'

  resources :generators
  resources :users do
    resources :documents, only: [:new, :create, :index]
  end
  resources :documents


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
