require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  root to: 'services#index'

  #devise_for :users, path: :neptun, path_names: {sign_in: :login, sing_out: :logout}, controllers: { registrations: 'users/registrations' }
  resources :servers, :groups, :scenarios
  resources :services do
    member do
      get :start
      get :stop
      get :restart
      get :start_scenario
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users
  end

end
