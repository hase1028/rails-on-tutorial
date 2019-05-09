class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def show
    @user = User.find(params[:id])    #paramsで:idパラメータを受け取る(/users/1にアクセスしたら1を受け取る)。DBからid:1のレコードをfindメソッドで取り出す
    #@tweets = @user.tweets.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:signup_success] = "アカウントを作成しました！"
        redirect_to @user
      else
        render 'new'
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      #if current_user == @user
        if @user.update_attributes(user_params)
          flash[:success] = 'プロフィールを更新しました。'
          redirect_to @user
        else
          flash.now[:danger] = 'ユーザー情報の編集に失敗しました'
          render 'edit'
        end
      #else
        #redirect_to root_url
      #end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザを削除しました"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    #beforアクション

    #ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    #正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
