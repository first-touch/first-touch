Rails.application.routes.draw do
  devise_for :users, controllers:
                       {
                         sessions: 'users/sessions',
                         registrations: 'users/registrations'
                       }

  root to: 'users#home'

  get 'welcome', controller: :visitors, action: :index

  namespace :api do
    namespace :v1 do
      resources :relationships, only: [:create, :destroy]
      resources :users, only: [:show, :update]
      get 'users/:id/follows', controller: :users, action: :follows
      resources :posts, only: [:index, :create, :update, :destroy]
      # Note: Named route for users search because later on the search will probably
      # be more broad.
      get 'search', controller: :users, action: :search
      resources :network, only: [:index]
      resources :messages, only: [:index, :create]
    end
  end
end
