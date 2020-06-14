Rails.application.routes.draw do
  resources :hashtags, only: :show
  resources :users
  resources :questions, except: [:show, :new, :index]
  resource :session, only: [:new, :create, :destroy]

  root 'users#index'
end
