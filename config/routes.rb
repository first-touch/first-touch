Rails.application.routes.draw do
  devise_for :users, controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
  }
  root to: 'visitors#home'

  resources :users, only: [:show]

  resources :interested_people, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :relationships, only: [:create, :destroy]
      resources :users, only: [:show, :update]
    end
  end
end
