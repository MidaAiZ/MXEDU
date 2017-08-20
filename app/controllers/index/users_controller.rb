class Index::UsersController < IndexController
  before_action :check_login
  before_action :set_index_user, only: [:show, :edit, :update, :destroy]

  # GET /index/users
  # GET /index/users.json
  def index
    @index_users = Index::User.all
  end

  # GET /index/users/1
  # GET /index/users/1.json
  def show
  end

  # GET /index/users/new
  def new
    @index_user = Index::User.new
  end

  # GET /index/users/1/edit
  def edit
  end

  # POST /index/users
  # POST /index/users.json
  def create
      prms = index_user_params # 获取注册参数
      @user = Index::User.new(prms) # 新建用户

      @cache = Cache.new # 获取cache对象实例
      msg_cache_key = Valicode.msg_cache_key(prms[:phone], 'register') # 获取注册cache的key值
      msg_record = @cache[msg_cache_key] # 从缓存中获取短信验证码记录

      msg_code = params[:msg_code] # 从注册参数中获取短信验证码

      # 验证注册传入的短信验证码是否正确
      unless msg_record && (msg_code == msg_record[:code])
          # 每条验证码最多允许5次验证失败
          tem_cache = msg_record[:times] > 4 ? nil : { code: msg_record[:code], times: msg_record[:times] + 1 }
          @cache[msg_cache_key, 10.minutes] = tem_cache
          @code ||= 'WrongMsgCode' # 短信验证码错误
      end

      if !@code && @user.save
          session[:user_id] = @user.id # 注册后即登录
          @cache[msg_cache_key] = nil # 注册后删除缓存
          @code = 'Success' # 注册成功
          # try_send_vali_email '注册新账号'
      end
      @code ||= 'Fail'
    respond_to do |format|
      if code == 'Success'
        format.html { redirect_to @index_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @index_user }
      else
        format.html { render :new }
        format.json { render json: @index_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/users/1
  # PATCH/PUT /index/users/1.json
  def update
    respond_to do |format|
      if @index_user.update(index_user_params)
        format.html { redirect_to @index_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @index_user }
      else
        format.html { render :edit }
        format.json { render json: @index_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_user
      @index_user = Index::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_user_params
      params.require(:index_user).permit(:number, :password_digest, :phone, :email, :name, :sex, :info)
    end
end
