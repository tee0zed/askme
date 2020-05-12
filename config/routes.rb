Rails.application.routes.draw do
  resources :users
  resources :questions, except: [:show, :new, :index]
  resources :sessions, only: [:new, :create, :destroy]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'

  root 'users#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
