Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      devise_for :users, only: [:confirmations]
      post 'users/reset_password', controller: :authentication, action: :reset_password
      put 'users/update_password', controller: :authentication, action: :update_password
      get 'settings/playing_positions', controller: :configurations, action: :playing_positions
      post 'authenticate', controller: :authentication, action: :authenticate
      get 'validate', controller: :authentication, action: :validate
      post 'logout', controller: :authentication, action: :logout
      post 'pre_register', controller: :visitors, action: :pre_register

      resources :relationships, only: [:create]
      delete 'relationships/:followed_user_id',
             controller: :relationships,
             action: :destroy

      # Public profile of user
      get 'users/:id/profile', controller: :users, action: :public_profile

      # Authenticated user actions: profile get and update
      resource :user, only: %i[show update]
      post 'users/:id/avatar', controller: :users, action: :avatar

      post 'users/register', to: 'users#register', as: :register
      post 'users/import', to: 'users#import', as: :import

      get 'users/:id/follows', controller: :users, action: :follows
      resource :users, except: [:show] do
        resources :posts, only: %i[index create], controller: 'users/posts'
      end
      resources :career_entries, only: %i[create update destroy]

      get 'club_token', to: 'users/club_token'

      resource :clubs, only: [] do
        get 'search', action: :search
        get 'countries', action: :countries
        post 'import_roster', action: :import_roster
        resources :posts, only: %i[index create], controller: 'clubs/posts'
      end
      resources :clubs, only: %i[index show update create]

      resources :posts, only: %i[update destroy]
      resources :teams, only: %i[index show]
      resources :competitions, only: %i[index]

      # Note: Named route for users search because later on
      # the search will probably be more broad.
      get 'search', controller: :users, action: :search
      resources :network, only: [:index]
      resources :messages, only: %i[index create]
      get 'messages/:chat_with_id', controller: :messages, action: :show
      get 'notes/tags', controller: :notes, action: :tags
      resources :notes do
        get 'tag/:tag', on: :collection, action: :index_by_tag
        get 'field_types', on: :collection, action: :field_types
      end
      post 'direct_upload/signed_url', to: 'direct_upload#signed_url'

      resources :events, only: %i[index create show]
      post 'connect', controller: :connection, action: :create
      post 'reports/refund/:report_id', controller: :orders, action: :refund
      resources :reports
      get 'reports/list/purchased', controller: :reports, action: :purchased
      resources :orders
      resources :requests
      resources :bids
      resources :stripe, only: %i[index create]
      delete 'stripe', controller: :stripe, action: :destroy
      put 'stripe', controller: :stripe, action: :update

      get 'stripe/required', controller: :stripe, action: :required

      get 'requests/bids/:request_id', controller: :bids, action: :requestbids
      post 'requests/bids/:request_id', controller: :bids, action: :acceptbid
      resource :club_stripes, :path => "club/stripe"
      resources :files, only: [:show, :new]

    end
  end
end
