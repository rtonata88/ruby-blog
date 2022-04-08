class PostsController < ApplicationController
  def index
    @user = User.includes(:comments, :posts).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end
end
