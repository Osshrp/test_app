require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { registrations: 'registrations' }

devise_scope :user do
  root to: "devise/sessions#new"
end

  resources :users, only: [:index, :show]

  namespace :admin do
    resources :users do
      get :send_info, on: :member
    end
  end
end
