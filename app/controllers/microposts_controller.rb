class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :retweet]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end
    
    def retweet
        @user = User.find(current_user.id)
        
        #オリジナルメッセージの取得
        @micropost = Micropost.find(params[:original_id])
        
        # 引用する内容を作成
        @original_text = 'RT @'
        @original_text << @micropost.user.name << ': '
        @original_text << @micropost.content
        #画像引用がうまくいかない...
        #@original_text << @micropost.image.file.file
        
        # micopostを初期化、original_idだけセット
        @micropost = current_user.microposts.build
        @micropost.original_id = params[:original_id]
    end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content, :image)
    end
    
end
