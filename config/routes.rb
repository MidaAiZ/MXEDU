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

    # 产品
    resources :products

    # 预约
    resources :appoints

    # 订单
    resources :orders

    # 资料
    resources :materials do
        collection do
            get 'download/:file_id/:filename' => 'materials#download'
        end
    end

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
    resources :admins do
    end

    # root
    get '' => 'main#index', as: :root

    get 'profile' => 'admins#profile', as: :profile

    # session
    get 'login' => 'session#index', as: :login
    post 'login' => 'session#login', as: :do_login
    post 'logout' => 'session#logout', as: :logout

    # counts
    get 'counts' => 'main#counts'
    get 'products_count' => 'main#products_count'
    get 'viewers_count' => 'main#viewers_count'

    # users
    resources :users do
        get 'appoints' => 'appoints#index', as: :appoints
        get 'histories' => 'histories#index', as: :histories
    end

    # products
    resources :products

    # products cate
    resources :product_cates

    # products company
    resources :product_companies

    # appoints
    resources :appoints

    # orders
    resources :orders

    #histories
    resources :histories

    #images
    resources :images

    # materials
    resources :materials do
        get 'upload' => 'materials#upload', as: :upload
        post 'upload' => 'materials#uploader', as: :uploader
        collection do
            get 'download/:file_id/:filename' => 'materials#download'
        end
    end

    # schools
    resources :schools

    # 轮播图
    resources :carousels

    #资料分类
    resources :material_cates

    # 文件上传
    post 'upload' => 'fileworkers#create', as: :upload

    # 轮播图
    resources :carousels do
        collection do
            get 'histories/all' => 'carousels#history', as: :history
            post '/:id' => 'carousels#update'
            post 'unshow/:id' => 'carousels#unshow', as: :unshow
            post 'reshow/:id' => 'carousels#reshow', as: :reshow
            post 'location/:id' => 'carousels#set_location', as: :lct_control
            delete '/:id' => 'carousels#destroy', as: :delete
        end
    end


  end

  get 'download/files/:id/:filename' => 'download#download'

  root 'index/main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
