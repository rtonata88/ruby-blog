class PostsController < ApplicationController
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
    user_id = params.require(:post).permit(:user_id)
    @user = User.where(id: user_id['user_id']).first
    @post = Post.new(params.require(:post).permit(:authenticity_token, :title, :text, :user_id))

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Saved successfully'
    else
      flash[:notice] = 'Whoops!! Please try again. Something went wrong'
      render 'posts/index'
    end
  end
end
