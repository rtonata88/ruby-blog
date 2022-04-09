class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    user = User.find(post.user_id)

    @comment = Like.new(post_id: post.id, user_id: user.id)

    if @comment.save
      redirect_to "/users/#{user.id}/posts/#{post.id}", notice: 'Saved successfully'
    else
      flash[:notice] = 'Whoops!! Please try again. Something went wrong'
      render 'posts/index'
    end
  end
end
