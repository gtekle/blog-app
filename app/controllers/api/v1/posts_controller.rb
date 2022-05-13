class Api::V1::PostsController < Api::V1::BaseController
  def index
    @posts = Post.where(author_id: params[:user_id])
    render json: @posts, status: :success
  end

  def show
    @post = Post.where(post_id: params[:post_id])
    render json: @post, status: :success
  end
end
