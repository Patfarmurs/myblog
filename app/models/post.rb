class Post < ApplicationRecord
  attribute :posts_count, :integer, default: 0
  validates :name, presence: true, length: { minimum: 2 }
  validates :posts_count, comparison: { greater_than_or_equal_to: 0 }
  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0
  
  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_count, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_count, comparison: { greater_than_or_equal_to: 0 } 
  
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :likes
  has_many :comments

  def show_recent_comment
    comment.where(post_id: id).first(5)
  end
end
