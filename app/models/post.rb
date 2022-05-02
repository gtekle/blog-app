class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_user_posts_counter

  def update_user_posts_counter
    user = User.find(author_id)
    user.update(posts_counter: user.posts_counter + 1)
  end

  def most_recent_comments
    Comment.order(created_at: :desc).where(post_id: id).first(5)
  end
end
