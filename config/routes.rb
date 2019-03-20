Rails.application.routes.draw do

  root to: 'services#index'
  devise_for :users, path: :neptuns, path_names: {sign_in: :login, sing_out: :logout}, controllers: { registrations: 'users/registrations' }
  resources :servers
  resources :groups  
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
