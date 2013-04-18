class UsersController < ApplicationController
  before_filter :authenticate_user!

  def pick_friends
  end
end

