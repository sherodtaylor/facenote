class FriendPage < ActiveRecord::Base
  attr_accessible :fb_id, :location, :notes, :user_id, :img, :name, :has_page
  validates :fb_id, :uniqueness => true
  belongs_to :user
  def to_param
    self.fb_id
  end

end
