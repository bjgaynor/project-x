Projectx::Application.routes.draw do
  root to: 'listings#index'
  resources :listings, only: [:index, :create, :show, :destroy]
end
