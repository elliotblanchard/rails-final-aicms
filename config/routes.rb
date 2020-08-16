Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :generators
  resources :documents
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
