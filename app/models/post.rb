class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :likes
  has_many :comments

  def show_recent_comment
    comment.where(post_id: id).first(5)
  end
end
