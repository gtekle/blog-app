class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_post_likes_counter

  private

  def update_post_likes_counter
    post = Post.find(post_id)
    post.update(likes_counter: post.likes_counter + 1)
  end
end
