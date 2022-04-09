class CommentsController < ApplicationController
  def create
    user_id = params.require(:post).permit(:user_id)
    @user = User.where(id: user_id['user_id']).first
    @post = Post.new(params.require(:post).permit(:title, :text, :user_id))

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Saved successfully'
    else
      flash[:notice] = 'Whoops!! Please try again. Something went wrong'
      render 'posts/index'
    end
  end
end
