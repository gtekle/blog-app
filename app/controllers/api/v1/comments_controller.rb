class Api::V1::CommentsController < Api::V1::BaseController
  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)

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
    comment_hash[:author] = User.find(params[:user_id])
    comment_hash[:post] = Post.find(params[:post_id])
    comment_hash
  end
end
