class AddOauthExpireAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_expires_at, :time
  end
end
