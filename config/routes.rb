Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', controller: :authentication, action: :authenticate
      get 'validate', controller: :authentication, action: :validate
      post 'logout', controller: :authentication, action: :logout
      post 'pre_register', controller: :visitors, action: :pre_register

      resources :relationships, only: [:create]
      delete 'relationships/:followed_user_id', controller: :relationships, action: :destroy

      # Public profile of user
      get 'users/:id/profile', controller: :users, action: :public_profile

      # Authenticated user actions: profile get and update
      resource :user, only: [:show, :update]


      post 'users/register', to: 'users#register', as: :register
      get 'users/:id/follows', controller: :users, action: :follows
      resources :posts, only: [:index, :create, :update, :destroy]
      # Note: Named route for users search because later on the search will probably
      # be more broad.
      get 'search', controller: :users, action: :search
      resources :network, only: [:index]
      resources :messages, only: [:index, :create]
      get 'messages/:chat_with_id', controller: :messages, action: :show
      resources :session_plans

      resource :clubs do
        get 'search', action: :search
      end
    end
  end
end
