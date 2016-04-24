class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  attr_accessor  :image  
  mount_uploader :image, ImageUploader  

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user


end
