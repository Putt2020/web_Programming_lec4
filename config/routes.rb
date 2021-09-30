Rails.application.routes.draw do
  get 'main', to: 'users#main'
  get '/userPost', to: 'users#userPost'
  get '/users/destroy', to: 'users#destroy'
  get '/users/Create_fast', to: 'users#revive'
  get 'userPost/:id', to: 'users#userPost'
  
  resources :users #do
    #resources :posts
  #end
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
