class CreateFriendPages < ActiveRecord::Migration
  def change
    create_table :friend_pages do |t|
      t.integer :user_id
      t.integer :fb_id
      t.string :location
      t.text :notes

      t.timestamps
    end
  end
end
