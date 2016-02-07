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
      resources :users, only: [:show]
    end
  end
end
