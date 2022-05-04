class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to "/users/#{params[:user_id]}/posts/#{@post.id}"
  end

  private

  def comment_params
    comment_hash = params.require(:comment).permit(:text)
    comment_hash[:author] = current_user
    comment_hash
  end
end
