class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, length: { maximum: 250 }, presence: true
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  after_create :update_user_posts_counter
  before_destroy :decrement_user_posts_counter

  def most_recent_comments
    Comment.includes(:author).order(created_at: :desc).where(post_id: id).first(5)
  end

  private

  def update_user_posts_counter
    user = User.find(author_id)
    user.update(posts_counter: user.posts_counter + 1)
  end

  def decrement_user_posts_counter
    user = User.find(author_id)
    user.update(posts_counter: user.posts_counter - 1)
  end
end
