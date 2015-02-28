Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  post 'create_user' => 'users#create', as: :create_user
  get 'user_activity' => 'user_logins#index', as: :user_activity
  resources :accounts, only: [:index, :show, :update, :create] do
    resources :account_transactions, controller: 'account_transactions'
  end
end
