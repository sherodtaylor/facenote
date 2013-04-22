class FriendPagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :fb_user_auth, :only => [:show_friend]

  def fb_user_auth
    friendpage_id = FriendPage.find_by_fb_id(params[:fb_id]).user_id
    unless current_user.id == friendpage_id
       redirect_to root_path 
    end
  end

  def pick_friends
    @friend_page = FriendPage.new
    @pictures = []
    @friends.each{|f| @pictures << f['picture']['data']['url']}
  end

  def show_friend
    @friend_page = FriendPage.find_by_fb_id(params[:fb_id])
    @friend_profile = @graph.get_object("#{@friend_page.fb_id}")
    @likes = @graph.get_connections("me", "likes/#{@friend_page.fb_id}")
    respond_to do |format|
        format.html
    end
  end

  def new
    @friend_page = FriendPage.new
  end

  def create
    @friend_page = FriendPage.new(:user_id => params[:user_id], :img => params[:img],  :fb_id => params[:fb_id], :name => params[:name], :has_page => params[:has_page]) 
    @friend_page.save
      if @friend_page.save
         redirect_to "/friend_pages/#{@friend_page.fb_id}" 
      else
         render action: "pick_friends" 
      end
  end

  def edit
    @friend_page = FriendPage.find_by_fb_id(params[:fb_id])
  end

  def update
    @friend_page = FriendPage.find_by_fb_id(params[:fb_id])
    @friend_page.update_attribute(:notes, params[:friend_page][:notes])
    @friend_page.update_attribute(:location, params[:friend_page][:location])
      redirect_to "/friend_pages/#{params[:fb_id]}"
  end

  def destroy
  end
end
