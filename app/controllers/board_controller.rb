class BoardController < ApplicationController
  allow_unauthenticated_access only: [:index]

  def index
    @registered_users = User.all
    @posts = Post.all
    @topics = Topic.all
  end
end
