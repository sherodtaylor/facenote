class AddOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth, :string
  end
end
