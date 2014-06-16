Projectx::Application.routes.draw do
  root to: 'listings#index'
  resources :listings, only: [:index, :create, :show, :destroy]
  resources :imports, only: [:index, :create, :show, :destroy]
  get '/upload', to: 'imports#upload'
end
