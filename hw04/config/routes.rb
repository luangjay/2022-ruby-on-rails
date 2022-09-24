Rails.application.routes.draw do
  get 'main/test'
  post 'main/test', to: 'main#calculate'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'main#root'
end
