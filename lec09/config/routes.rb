Rails.application.routes.draw do
  get 'main/login'
  post 'main/authenticate'
  get 'main/logout'
  resources :scores
  resources :students
  get 'students/:id/edit_score', to: 'students#edit_score', as: 'edit_student_score'
  delete 'students/:id/edit_score', to: 'students#edit_score', as: 'delete_student_score'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
