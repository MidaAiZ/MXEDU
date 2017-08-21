Rails.application.routes.draw do
  scope module: :index do
    get 'login' => 'session#index', as: :login
    post 'login' => 'session#login'
    post 'logout' => 'session#logout'

    resources :users, as: :index_user do
      collection do
        get 'profile' => 'users#show'
      end
    end

    resources :products, as: :index_product
  end

  root 'index/main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
