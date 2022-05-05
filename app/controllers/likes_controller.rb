class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(author: current_user, post: @post)
    respond_to do |format|
      if @post
        format.html do
          redirect_to user_post_path(User.find(params[:user_id]), @post), notice: 'You have liked the post!'
        end
      end
    end
  end
end
