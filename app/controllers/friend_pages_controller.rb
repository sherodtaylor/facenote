class FriendPagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :fb_user_auth, :only => [ :show ]

  def fb_user_auth
    unless current_user.id == FrkendPage.find_by_fb_id(params[:fb_id])
       redirect_to root_path 
    end
  end

  def pick_friends
    @friend_page = FriendPage.new
    @pictures = []
    @friends.each{|f| @pictures << f['picture']['data']['url']}
  end

  def show
    @friend_page = FriendPage.find_by_fb_id(params[:fb_id])
  end

  def new
    @friend_page = FriendPage.new
  end

  def create
    @friend_page = FriendPage.new(:user_id => params[:user_id], :fb_id => params[:fb_id], :name => params[:name], :has_page => params[:has_page]) 
    @friend_page.save
    respond_to do |format|
      if @friend_page.save
        format.html { render action: "show" } 
      else
        format.html { render action: "pick_friends" }
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
