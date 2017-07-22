Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'users#index'

  resources :users, only: [:index, :show]

  namespace :admin do
    resources :users
  end
end
