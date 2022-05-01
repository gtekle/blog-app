class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_post_likes_counter(post_id)
    post = Post.find(post_id)
    post.update(likes_counter: 1)
  end
end
