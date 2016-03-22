class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :introduce, :string
  end
end
