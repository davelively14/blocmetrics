Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :user, only: [:edit] do
    resources :registered_applications, only: [:show, :index]
  end
end
