Rails.application.routes.draw do
  resources :inventories, path: 'main/inventories', only: [:index]
  resources :items, path: 'main/user_item', except: [:show]
  get 'main/login'
  post 'main/authenticate'
  get 'main/logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'shop/:id', to: 'shop#show'
  get 'buy/:id', to: 'shop#buy'
  post 'buy/:id', to: 'shop#transact'

  # Defines the root path route ("/")
  # root "articles#index"
end
