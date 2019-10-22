class PostsController < ApplicationController
  before_action :authorize
  
  # 新規投稿ページ
  def new
    @post = Post.new
  end
  
  # 投稿処理
  def create
    # パラメータ受け取り
    @post = Post.new(post_params)
    upload_file = params[:post][:upload_file]
    
    # 投稿画像がない場合
    if upload_file.blank?
      flash[:danger] = "投稿には画像が必須です。"
      redirect_to new_post_path and return
    end
    
    # 画像のファイル名取得
    upload_file_name = upload_file.original_filename
    output_dir = Rails.root.join('public', 'images')
    output_path = output_dir + upload_file_name
    
    # 画像のアップロード
    File.open(output_path, 'w+b') do |f|
      f.write(upload_file.read)
    end
    
    # post_imagesテーブルに登録するファイル名をPostインスタンスに格納
    @post.post_images.new(name: upload_file_name)
    
    # データベースに保存
    if @post.save
      # 登録したらtopページへ
      flash[:success] = '投稿しました'
      redirect_to top_path
    else
      # 登録が失敗したら投稿ページへ
      flash[:danger] = "投稿に失敗しました。"
      redirect_to posts_path
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:caption).merge(user_id: current_user.id)
  end
end
