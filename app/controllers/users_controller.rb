class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
include SessionsHelper

  def show
    #@user = User.find(params[:id])
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
    @session_id = session[:user_id]
    #ログインユーザ本人の情報しか編集不可
    # if params[:id] != @session_id.to_s
    if current_user != @user
      flash[:danger] = "Please log in as a correct user."
      redirect_to login_url
    end
  end
  
  def update
    @session_id = session[:user_id]
    #ログインユーザ本人の情報しか編集不可
    #if params[:id]==@session_id.to_s
    if current_user == @user
      if @user.update(user_params)
        #　保存に成功した場合はトップページへリダイレクト
        flash[:success] = "プロフィールを編集しました。"
        redirect_to root_path
      else 
        #@users = User.all
        # 保存に失敗した場合は編集画面へ戻す
        flash.now[:alert] = "プロフィールの保存に失敗しました。"
        render 'edit'
      end
    else 
      flash[:danger] = "Please log in as a correct user."
      redirect_to login_url
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce, :place, :birthday)
  end

  def set_user
    SessionsHelper
    #@user = User.find(params[:id])
    
    @user = User.find_by_id(params[:id]) if params[:id]
    render(:nothing => true, :status => '404 Not Found') unless @user

  end
end
