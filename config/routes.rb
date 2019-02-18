Rails.application.routes.draw do

  root to: 'servers#index'
  devise_for :users, path: :neptuns, path_names: {sign_in: :login, sing_out: :logout}
  resources :servers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
