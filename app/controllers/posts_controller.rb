class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    respond_to do |format|
      format.html { redirect_to user_posts_path(@user), notice: 'Post successfully created!' } if @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
