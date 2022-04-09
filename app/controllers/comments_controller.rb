class CommentsController < ApplicationController
  def create
    user_id = params.require(:post).permit(:user_id)
    user = User.where(id: user_id['user_id']).first
    post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:post).permit(:text, :post_id, :user_id))

    if @comment.save
      redirect_to "/users/#{user.id}/posts/#{post.id}", notice: 'Saved successfully'
    else
      flash[:notice] = 'Whoops!! Please try again. Something went wrong'
      render 'posts/index'
    end
  end
end
