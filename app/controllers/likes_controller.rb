class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(author: current_user, post: @post)
    redirect_to user_post_path(User.find(params[:user_id]), @post)
  end
end
