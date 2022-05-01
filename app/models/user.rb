class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def self.most_recent_posts
    all
  end
end
