Rails.application.routes.draw do
  # OPTIONS请求
  match 'controller', to: 'controller#action', via: [:options]
  resources :controller

  scope module: :index do
    get 'login' => 'session#index', as: :login
    post 'login' => 'session#login', as: :do_login
    post 'logout' => 'session#logout'

    resources :users do
      collection do
        get 'profile' => 'users#show'
      end
    end

    resources :products

    resources :products, as: :index_product

    #user center
    scope 'ucenter', as: :ucenter do
        # profile
        get '' => 'user_center#index'

        # orders
        get 'orders' => 'user_center#orders'
        get 'orders/:id' => 'user_center#order'

        #histories
        get 'histories' => 'user_center#histories'
        get 'histories/:id' => 'user_center#histories'
    end

    # verify
    post 'verify_code' => 'verify#check_code'
    post 'send_msg' => 'verify#send_msg_code'
    post 'verify_msg' => 'verify#check_msg_code'
    get 'verify_email' => 'verify#check_email'

  end

  namespace :manage do
    resources :admins

    # session
    get 'login' => 'session#index'
    post 'login' => 'session#login'
    post 'logout' => 'session#logout'

    # orders
    get 'orders' => 'orders#index'
    get 'orders/:id' => 'orders#show'

    #histories
    get 'histories' => 'histories#index'
    get 'histories/:id' => 'histories#show'
  end

  root 'index/main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
