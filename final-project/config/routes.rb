Rails.application.routes.draw do
  get 'login', to: 'main#login'
  get 'logout', to: 'main#logout'
  post 'authenticate', to: 'main#authenticate'
  get 'profile', to: 'main#profile'
  post 'change_password', to: 'main#change_password'
  get 'main', to: 'main#index'
  get 'my_market', to: 'main#my_market'
  get 'my_market/buy/:id', to: 'main#my_market_buy'
  post 'my_market/buy/:id', to: 'main#my_market_buy_post'
  get 'purchase_history', to: 'main#purchase_history'
  get 'sale_history', to: 'main#sale_history'
  get 'my_inventory', to: 'main#my_inventory'
  get 'my_inventory/edit/:id', to: 'main#my_inventory_edit'
  post 'my_inventory/edit/:id', to: 'main#my_inventory_edit_post'
  post 'my_inventory/delete/:id', to: 'main#my_inventory_delete'
  get 'my_inventory/new', to: 'main#my_inventory_new'
  post 'my_inventory/new', to: 'main#my_inventory_new_post'
  get 'top_seller', to: 'main#top_seller'
  post 'top_seller', to: 'main#top_seller_post'
  resources :items
  resources :users
  
  #resources :inventories, path: 'main/inventories', only: [:index]
  #resources :items, path: 'main/user_item', except: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
