class Comment < ApplicationRecord
  belongs_to :blog_post
  validates :user, presence: true
  validates :body, presence: true
end
