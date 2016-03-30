class LikesController < ApplicationController
    
    #def create
    #    @micropost = Micropost.find(params[:micropost])
    #    current_user.check_like(@micropost)
    #end

    #def destroy
    #    @user = current_user.favorite_posts.find(params[:id]).micropost
    #    current_user.unlike(@user)
    #end

    def create
        @micropost = Micropost.find(params[:micropost_id])
        @like = current_user.likes.build(micropost: @micropost)
        if @like.save
            redirelct_to root_url,notice: "お気に入りに登録しました。"
        else
            redirect_to root_url, alert:"このツイートはお気に入りに登録できません"
        end
    end
	
	def destroy
	    @like = current_user.likes.find_by!(micropost_id: params[:micropost_id])
	    @like.destroy
	    redirect_to root_url, notice: "お気に入りを解除しました。"
	end
end
