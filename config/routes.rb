Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  post 'create_user' => 'users#create', as: :create_user
end
