class PostsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = User.includes(:comments, :posts).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @user = current_user
    @post = Post.new(params.require(:post).permit(:authenticity_token, :title, :text, :user_id))
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post was successfully created.'
    else
      flash[:notice] = 'Something went wrong!'
      render 'posts/index'
    end
  end
end
