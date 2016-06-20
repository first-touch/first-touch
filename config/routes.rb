Rails.application.routes.draw do
  devise_for :users, controllers: {
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
    end
  end
end
