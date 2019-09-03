require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  root to: 'services#index'

  devise_for :users, path: :neptun, path_names: {sign_in: :login, sing_out: :logout}, controllers: { registrations: 'users/registrations' }
  resources :servers, :groups, :scenarios
  resources :services do
    member do
      get :start
      get :stop
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users
  end

end
