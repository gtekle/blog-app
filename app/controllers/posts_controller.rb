class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

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
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@user), success: 'Post successfully created!' }
      else
        format.html { redirect_to user_posts_path(@user), danger: 'Post was not created!' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    Comment.where(post_id: @post.id).destroy_all
    Like.where(post_id: @post.id).destroy_all
    Post.destroy(@post.id)
    @user = User.find(params[:user_id])

    respond_to do |format|
      if Post.find(params[:id]).nil?
        format.html { redirect_to user_posts_path(@user), success: 'Post successfully delete!' }
      else
        format.html { redirect_to user_posts_path(@user), danger: 'Post was not deleted!' }
      end
    end
  end

  private

  def post_params
    post_hash = params.require(:post).permit(:title, :text)
    post_hash[:author] = current_user
    post_hash
  end
end
