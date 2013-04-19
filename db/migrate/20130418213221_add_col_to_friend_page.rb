class AddColToFriendPage < ActiveRecord::Migration
  def change
    add_column :friend_pages, :img, :string
    add_column :friend_pages, :name, :string
    add_column :friend_pages, :has_page, :boolean
  end
end
