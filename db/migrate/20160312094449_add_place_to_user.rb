class AddPlaceToUser < ActiveRecord::Migration
  def change
    add_column :users, :place, :string
  end
end
