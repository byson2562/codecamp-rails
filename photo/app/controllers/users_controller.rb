class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_up_process, :sign_in, :sign_in_process]
  before_action :redirect_to_top_if_signed_in, only: [:sign_up, :sign_in]

  # ユーザー登録
  def sign_up
    @user = User.new
    render layout: "application_not_login"
  end

  def sign_up_process
    @user = User.new(user_params) 
    if @user.save
      # 登録が成功したらサインインしてトップページへ
      user_sign_in(@user)
      redirect_to top_path and return
    else
      # 登録が失敗したらユーザー登録ページへ
      flash[:danger] = "ユーザー登録に失敗しました。"
      redirect_to sign_up_path
    end
  end

  # ログイン処理
  def sign_in
    @user = User.new
    render layout: "application_not_login"
  end

  def sign_in_process
    # パスワードをmd5に変換
    password_md5 = User.generate_password(user_params[:password])
    user = User.find_by(email: user_params[:email], password: password_md5)
    if user
      # セッション処理
      user_sign_in(user)
      # トップ画面へ遷移する
      redirect_to top_path and return
    end
  end
  
  # サインアウト処理
  def sign_out
    # ユーザーセッションを破棄
    user_sign_out
    # サインインページへ遷移
    redirect_to sign_in_path and return
  end

  def top
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def edit
    @user = User.find(current_user.id)
    upload_file = params[:user][:image]
    if upload_file.present?
      # あった場合はこの中の処理が実行される
    end
  end

  def follower_list
  end
  
  def follow_list
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
end
