Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :user, only: [:edit]
  resources :registered_applications, only: [:show, :index, :new, :create, :destroy]
end
