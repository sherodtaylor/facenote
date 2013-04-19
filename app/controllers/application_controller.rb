class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :koala

  def koala
    if current_user 
    @graph = Koala::Facebook::API.new(current_user.oauth)
    @profile = @graph.get_object("me")
    @picture = @graph.get_picture(@profile['id'])
    @friends = @graph.get_connections("me", "friends?fields=id,name,picture.type(large)")
    end
  end
end
