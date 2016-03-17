class UsersController < ApplicationController
before_action :set_user, only: [:show, :destroy]
before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
      if @user.update(user_params)
        #　保存に成功した場合はプロフィール画面へ
        flash[:success] = "プロフィールを編集しました。"
        redirect_to user_url
      else 
        # 保存に失敗した場合は編集画面へ戻す
        flash.now[:alert] = "プロフィールの保存に失敗しました。"
        render 'edit'
      end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce, :place, :birthday)
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    # 本人以外のデータ編集は不可。params[:id] が違う場合はトップページへ
    @user= User.find(params[:id])
    redirect_to root_url if @user != current_user
  end
  
end
