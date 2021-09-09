Rails.application.routes.draw do
  resources :users
  
  get '/users/destroy', to: 'users#destroy'
  get '/users/Create_fast', to: 'users#revive'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
