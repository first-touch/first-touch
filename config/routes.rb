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

      # TODO: Make routes more restful. Migrate this to resources :users
      # Public profile of user
      get 'users/:id/profile', controller: :users, action: :public_profile

      # Authenticated user actions: profile get and update
      resource :user, only: %i[show update]

      # TODO: Make routes more restful. Migrate this to resources :users
      post 'users/:id/avatar', controller: :users, action: :avatar

      post 'users/register', to: 'users#register', as: :register
      post 'users/import', to: 'users#import', as: :import

      get 'users/:id/follows', controller: :users, action: :follows
      # TODO: For making this app fully restful we should migrate this
      # to create the route users/<id>/posts and then on create, validate
      # that the requestor has permission to create a post on behalf of the
      # user
      resource :users, except: [:show] do
        resources :posts, only: %i[index create], controller: 'users/posts'
      end

      resources :users, only: [] do
        resources :media, only: %i[create destroy]
      end
      resources :career_entries, only: %i[create update destroy]

      namespace :scout, only: [] do
        resources :requests, only: [:index]
        resources :request_bids, only: %i[index create update]
        resources :reports, only: %i[index create update show]
      end

      namespace :director, only: [] do
        resources :requests, only: [:index]
      end

      namespace :agent, only: [] do
        resources :requests, only: [:index]
      end

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
      get 'users/search', controller: :users, action: :search
      resources :network, only: [:index]
      resources :messages, only: %i[index create]
      get 'messages/:chat_with_id', controller: :messages, action: :show
      get 'notes/tags', controller: :notes, action: :tags
      resources :notes do
        get 'tag/:tag', on: :collection, action: :index_by_tag
        get 'field_types', on: :collection, action: :field_types
      end

      post 'direct_upload', to: 'direct_upload#create'
      post 'direct_upload/signed_url', to: 'direct_upload#signed_url'
      post 'direct_upload/signed_request', to: 'direct_upload#signed_request'

      resources :events, only: %i[index create show]
      post 'connect', controller: :connection, action: :create
      put 'connect/:connection_id/accept', controller: :connection, action: :accept
      post 'reports/refund/:report_id', controller: :orders, action: :refund

      get 'reports/list/purchased', controller: :reports, action: :purchased
      resources :orders
      resources :stripe, only: %i[index create]
      delete 'stripe', controller: :stripe, action: :destroy
      put 'stripe', controller: :stripe, action: :update

      get 'stripe/required', controller: :stripe, action: :required

      resource :club_stripes, path: 'club/stripe'
      resources :files, only: %i[show new]

      # TODO: Deprecated. use namespaced routes instead
      resources :requests
    end
  end
end
