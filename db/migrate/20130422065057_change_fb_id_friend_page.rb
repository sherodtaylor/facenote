class ChangeFbIdFriendPage < ActiveRecord::Migration
  def change
    change_column :friend_pages, :fb_id, :bigint
  end
end
