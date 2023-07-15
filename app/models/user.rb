class User < ApplicationRecord
  attribute :posts_count, :integer, default: 0
  validates :name, presence: true, length: { minimum: 2 }
  validates :posts_count, comparison: { greater_than_or_equal_to: 0 } 

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def show_recent_post
    posts.where(author_id: id).first(3)
  end
end
