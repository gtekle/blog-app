class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@user, @post), success: 'Comment successfully created!' }
      else
        format.html { redirect_to user_post_path(@user, @post), danger: 'Comment is not created!' }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    Comment.destroy(@comment.id)

    respond_to do |format|
      if Comment.find(params[:id]).empty?
        format.html { redirect_to user_post_path(@user, @post), success: 'Comment successfully deleted!' }
      else
        format.html { redirect_to user_post_path(@user, @post), danger: 'Comment is not deleted!' }
      end
    end
  end

  private

  def comment_params
    comment_hash = params.require(:comment).permit(:text)
    comment_hash[:author] = current_user
    comment_hash[:post] = Post.find(params[:post_id])
    comment_hash
  end
end
