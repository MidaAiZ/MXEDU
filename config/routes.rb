Rails.application.routes.draw do
  namespace :index do
    resources :products
  end
  scope module: :index do
    get 'login' => 'session#index', as: :login
    post 'login' => 'session#login'
    post 'logout' => 'session#logout'

    resources :users, as: :index_user
  end

  root 'index/main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
