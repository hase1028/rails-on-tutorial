class UsersController < ApplicationController

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
          flash[:success] = 'ユーザー情報を編集しました'
          render :edit
        else
          flash.now[:danger] = 'ユーザー情報の編集に失敗しました'
          render :edit
        end
      #else
        #redirect_to root_url
      #end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
  end
