class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(:comments, :posts).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post } }
    end
  end

 def create
    # new object from params
    post = Post.new(author: current_user, title: params[:post][:title], text: params[:post] [:text])
    # respond_to block
    respond_to do |format|
      format.html do
        if post.save
          # success message
          flash[:success] = 'Post created successfully'
          # redirect to index
          redirect_to "/users/#{current_user.id}/posts"
        else
          # error message
          flash.now[:error] = 'Error: Post could not be created'
          # render new
          render :new, locals: { post: post}
        end
      end
    end
  end
end
