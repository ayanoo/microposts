class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  attr_accessor  :image  
  mount_uploader :image, ImageUploader  
  mount_uploader :avatar, AvatarUploader


    # お気に入りをつける
    def check_like(microposts)
        #favorite_posts.find_or_create_by(micropost: microposts.id)
        likes.find_or_create_by(micropost: microposts.id)
    end
    
    # お気に入りを解除する
    def unlike(micropost_id)
        user_like = favorite_posts.find_by(micropost_id: micropost_id)
        user_like.destroy if user_like
    end

    # お気に入りしているかどうか
    def favorite?(current_user)
        likes.where(user_id: current_user.id).exists?
    end
    

end
