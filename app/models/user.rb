class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def self.most_recent_posts(id)
    Post.order(created_at: :desc).where(author_id: id).first(3)
  end
end
