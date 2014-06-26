Projectx::Application.routes.draw do
  root to: 'listings#index'
  resources :listings, only: [:index, :create, :destroy]
  resources :imports, only: [:index, :create, :show, :destroy]
  post '/upload', to: 'imports#upload'
  get '/show/all', to: 'listings#show_all'
  get '/destroy/all', to: 'listings#destroy_all'
end
