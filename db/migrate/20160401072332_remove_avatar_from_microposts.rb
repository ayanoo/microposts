class RemoveAvatarFromMicroposts < ActiveRecord::Migration
  def change
    remove_column :microposts, :avatar, :string
  end
end
