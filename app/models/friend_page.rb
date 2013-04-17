class FriendPage < ActiveRecord::Base
  attr_accessible :fb_id, :location, :notes, :user_id
  belongs_to :user
end
