class Api::V1::UsersController < Api::V1::BaseController
  def index
    @users = Post.all
    render json: @users, status: :success
  end

  def show
    @user = User.where(params[:user_id])
    render json: @user, status: :success
  end
end
