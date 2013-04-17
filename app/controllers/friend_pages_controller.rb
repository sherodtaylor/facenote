class FriendPagesController < ApplicationController
  before_filter :authenticate_user!
  def friendpage
  end

  def new
    @friend_page = FriendPage.new
  end

  def create
    @friend_page = FriendPage.new(params[:friend_page])
    respond_to do |format|
      if @friend_page.save
        format.html { render :text => 'It has been created' }
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
