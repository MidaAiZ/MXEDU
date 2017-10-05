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
        post 'update/avatar' => 'users#update_avatar'
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

    # 帖子
    resources :posts do
        resources :post_comments
        collection do
            post '/:id/thumb' => 'posts#thumb_up', as: :thumb
            delete '/:id/thumb' => 'posts#thumb_cancel'
            get 'search' => 'posts#search', as: :search
            get 'hots' => 'posts#hots'
        end
    end

    # post notice
    resources :post_notices do
    end

    # 帖子评论
    resources :post_comments do
        resources :post_son_comments
        collection do
            post '/:id/thumb' => 'post_comments#thumb_up', as: :thumb
            delete '/:id/thumb' => 'post_comments#thumb_cancel'
        end
    end

    # 图片
    resources :images do

    end

    #user center
    scope 'ucenter', as: :ucenter do
        # profile
        get '' => 'user_center#index'

        get 'posts' => 'user_center#posts'

        # orders
        get 'orders' => 'user_center#orders'
        get 'orders/:id' => 'user_center#order'

        #histories
        get 'histories' => 'user_center#histories'
        get 'histories/:id' => 'user_center#histories'
    end

    # visit other user's profile
    scope 'visit_users', as: :v_ucenter do
        get ':id' => 'visit_user#index'
        get ":id/posts" => 'visit_user#posts', as: :posts
    end

    # 条件筛选
    scope 'conditions', as: :cdts do
        scope 'search', as: :search do
            get 'companies' => 'conditions#search_company'
            get 'material_cates' => 'conditions#search_material_cate'
            get 'product_cates' => 'conditions#search_product_cate'
            get 'schools' => 'conditions#search_school'
        end
    end

    # verify
    post 'verify_code' => 'verify#check_code'
    post 'send_msg' => 'verify#send_msg_code'
    post 'verify_msg' => 'verify#check_msg_code'
    get 'verify_email' => 'verify#check_email'

  end

  namespace :manage do
    resources :admins do
        collection do
            post 'update/avatar' => 'admins#update_avatar'
        end
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
    get 'total_count' => 'main#total_count'

    # users
    resources :users do
        get 'posts' => 'users#posts', as: :posts
        get 'appoints' => 'appoints#index', as: :appoints
        get 'histories' => 'histories#index', as: :histories
        get 'mat_histories' => 'mat_histories#index', as: :mat_histories
    end

    # products
    resources :products do
        post "/recover" => "products#recover", as: :recover
        collection do
            get "deleted" => "products#deleted_index", as: :deleted
        end
    end

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
    resources :mat_histories

    #images
    resources :images

    # materials
    resources :materials do
        get 'upload' => 'materials#upload', as: :upload
        post 'upload' => 'materials#uploader', as: :uploader
        post "/recover" => "materials#recover", as: :recover
        delete '/files/:file_id' => 'materials#delete_file'
        collection do
            get "deleted" => "materials#deleted_index", as: :deleted
            get 'download/:file_id/:filename' => 'materials#download'
        end
    end

    # posts
    resources :posts do
        resources :post_comments
        post 'recover' => 'posts#recover', as: :recover
        post 'top' => 'posts#on_top', as: :on_top
        delete 'top' => 'posts#off_top', as: :off_top

        collection do
            get 'search' => 'posts#search', as: :search
            get 'deleted' => 'posts#index_deleted', as: :deleted
            get 'forbidden' => 'posts#index_forbidden', as: :forbidden
        end
    end

    # post_comments
    resources :post_comments do
        resources :post_son_comments
        collection do
            delete '/:id/thumb' => 'post_comments#thumb_cancel'
        end
    end

    # post notice
    resources :post_notices do
        post "/recover" => "post_notices#recover", as: :recover
        collection do
            get "deleted" => "post_notices#deleted_index", as: :deleted
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
