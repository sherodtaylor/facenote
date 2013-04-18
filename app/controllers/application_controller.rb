class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :koala

  def koala
    if current_user 
    @graph = Koala::Facebook::API.new(current_user.oauth)
    @profile = @graph.get_object("me")
    @picture = @graph.get_picture(@profile['id'])
    end
  end
end
