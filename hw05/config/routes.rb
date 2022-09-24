Rails.application.routes.draw do
  get 'main/add'
  post 'main/add'
  #get 'main/edit'
  get 'main/edit/:id', to: 'main#edit'
  post 'main/edit/:id', to: 'main#edit'
  post 'main/delete/:id', to: 'main#delete'
  post 'main/delete-all', to: 'main#delete_all'
  #get 'main/result'
  #post 'main/result'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root 'main#index'
end
