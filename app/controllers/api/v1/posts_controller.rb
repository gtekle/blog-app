class Api::V1::PostsController < Api::V1::BaseController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
    render json: @posts
  end
end
