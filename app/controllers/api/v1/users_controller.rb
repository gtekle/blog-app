class Api::V1::UsersController < Api::V1::BaseController
  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.where(params[:user_id])
    render json: @user, status: 200
  end
end
