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
        @micropost = Micropost.find(params[:id])
        #いいねをつける
        current_user.press_like(@micropost)

    end
	
	def destroy
	    @micropost = Micropost.find(params[:id])
	    current_user.press_unlike(@micropost)
	end
end
