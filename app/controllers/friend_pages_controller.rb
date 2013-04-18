class FriendPagesController < ApplicationController
  before_filter :authenticate_user!
  caches_page :pick_friends
  
  def pick_friends
    @friends = @graph.get_connections("me", "friends")
  end

  def new
    @friend_page = FriendPage.new
  end

  def create
    @friend_page = FriendPage.new(params[:friend_page])
    @user = request.env["omniauth.auth"]
    respond_to do |format|
      if @friend_page.save
        format.html { render action: "friend_page"}
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @friend_page = FriendPage.find(params[:friend_page])
  end

  def update
    @friend_page = FriendPage.find(params[:friend_page])
  end

  def destroy
  end
end
