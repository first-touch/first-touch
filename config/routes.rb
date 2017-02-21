Rails.application.routes.draw do
  root to: 'users#home'

  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'logout', to: 'authentication#logout'
      post 'pre_register', to: 'visitors#pre_register'

      resources :relationships, only: [:create, :destroy]
      resources :users, only: [:show]
      resource :users, only: [:update]
      post 'users/register', to: 'users#register', as: :register
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
