class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def self.update_user_posts_counter(id)
    user = User.find(id)
    user.update(posts_counter: 1)
  end

  def self.most_recent_comments(id)
    Comment.order(created_at: :desc).where(post_id: id).first(5)
  end
end
