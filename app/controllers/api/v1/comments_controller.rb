class Api::V1::CommentsController < Api::V1::BaseController
  include ActionController::HttpAuthentication::Token

  before_action :authenticate_user, only: %i[create destroy]

  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments, status: 200
  end

  def create
    @comment = Comment.new(comment_params)
    p request.headers['Authorization'].split.last

    if @comment.save
      render json: @comment, status: 201
    else
      render json: "Comment is not created! User with id #{params[:user_id]} is not authorized to create comments!",
             status: 401
    end
  end

  private

  def comment_params
    comment_hash = params.require(:comment).permit(:text)
    comment_hash[:author] = authenticate_user
    comment_hash[:post] = Post.find(params[:post_id])
    comment_hash
  end

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    User.find(user_id)
  end
end
