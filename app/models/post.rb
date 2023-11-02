class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def update_post_counter
    self.comment_counter = comments.count
    save
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end