class Index::UsersController < IndexController
  before_action :require_login, only: [:edit]
  layout false, only: :new

  # GET /index/users/new
  def new
    @user = Index::User.new
    @schools = Manage::School.limit(8)
  end

  def show
    redirect_to v_ucenter_path(params[:id])
  end

  # GET /index/users/1/edit
  def edit
    @schools = Manage::School.where(id: @user.school_id) + Manage::School.where.not(id: @user.school_id).limit(7)
    set_title "修改资料"
  end

  # POST /index/users
  # POST /index/users.json
  def create
      prms = user_params # 获取注册参数
      @user = Index::User.new(prms) # 新建用户
      @user.number = prms[:phone]

      @cache = Cache.new # 获取cache对象实例
      msg_cache_key = Valicode.msg_cache_key(prms[:phone], 'register') # 获取注册cache的key值
      msg_record = @cache[msg_cache_key] || { times: 0 } # 从缓存中获取短信验证码记录

      msg_code = params[:msg_code] # 从注册参数中获取短信验证码

      # 验证注册传入的短信验证码是否正确
      if msg_code.nil? || (msg_code != 'xueba' && (msg_code != msg_record[:code]))
          # 每条验证码最多允许5次验证失败
          tem_cache = msg_record[:times] > 4 ? nil : { code: msg_record[:code], times: msg_record[:times] + 1 }
          @cache[msg_cache_key, 10.minutes] = tem_cache
          @code ||= 'WrongMsgCode' # 短信验证码错误
      end

      @user.name = '虚拟用户' if msg_code == 'xueba'
      @user.password = 'xueba1234' if msg_code == 'xueba'

      if !@code && @user.save
          session[:user_id] = @user.id # 注册后即登录
          @cache[msg_cache_key] = nil # 注册后删除缓存
          @code = 'Success' # 注册成功
          # try_send_vali_email '注册新账号'
      end
      @code ||= 'Fail'
    respond_to do |format|
      if @code == 'Success'
        format.html { redirect_to Cache.new[request.remote_ip + '_history'] || root_path }
        format.json { render json: { code: @code, url: Cache.new[request.remote_ip + '_history'] || root_path } }
      else
        format.html { redirect_to new_user_path }
        format.json { render json: { code: @code, errors: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/users/1
  # PATCH/PUT /index/users/1.json
  def update
    respond_to do |format|
      if @user.update(update_user_params)
        Cache.new["logged_user_#{@user.id}"] = nil
        format.html { redirect_to ucenter_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_avatar
    prms = params
    @user.x = prms[:x]
    @user.y = prms[:y]
    @user.width = prms[:width]
    @user.height = prms[:height]
    @user.rotate = prms[:rotate]
    avatar = prms[:avatar]
    avatar = @user.avatar.thumb if avatar.blank?
    respond_to do |format|
      if @user.update(avatar: avatar)
        format.json { render :show }
      else
        format.json { render json: @user.errors }
      end
    end
  end

  def check_phone_uniq
    uniq = true
    if Index::User.find_by_phone params[:phone]
      uniq = false
    end
    render json: { uniq: uniq }
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:index_user).permit(:number, :password, :phone, :email, :name, :sex, :school_id, :major, :grade, :nickname)
    end

    def update_user_params
      params.require(:index_user).permit(:password, :email, :name, :sex, :school_id, :major, :grade, :nickname)
    end
end
