Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :user, only: [:edit]
  resources :registered_applications

  namespace :api, defaults: { format: :json } do
    resources :events, only: [:create]
  end

  # Matches an HTTP options request, which is the CORS way of checking if
  # a cross domain request will be permitted, and calls the preflight method
  # in the EventsController.
  match 'api/events', to: 'api/events#preflight', via: [:options]
end
