class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_create :update_post_comments_counter
  before_destroy :decrement_post_comments_counter

  private

  def update_post_comments_counter
    post = Post.find(post_id)
    post.update(comments_counter: post.comments_counter + 1)
  end

  def decrement_post_comments_counter
    post = Post.find(post_id)
    post.update(comments_counter: post.comments_counter - 1)
  end
end
