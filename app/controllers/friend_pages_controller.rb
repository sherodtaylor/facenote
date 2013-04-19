class FriendPagesController < ApplicationController
  before_filter :authenticate_user!

  def pick_friends
    @friends = @graph.get_connections("me", "friends?fields=id,name,picture.type(large)")
    @friend_page = FriendPage.new
    @pictures = []
    @friends.each{|f| @pictures << f['picture']['data']['url']}
  end



  def new
    @friend_page = FriendPage.new
  end

  def create
    #friend_page = FriendPage.new(params[:friend_page])
    @friend_page = FriendPage.new(:user_id => params[:user_id], :fb_id => params[:fb_id], :name => params[:name]) 
    @friend_page.save
    @friendadded = FriendPage.last
    #friend_page.save
    # @user = request.env["omniauth.auth"]
    respond_to do |format|
      if @friend_page.save
        format.html { render :text => "#{@friendadded.inspect}"}
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
