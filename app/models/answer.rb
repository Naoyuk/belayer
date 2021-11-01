class Answer < ApplicationRecord
  validates :body, presence: true

  belongs_to :post
  belongs_to :user

  def unread
    self.read = false
    self.save!
  end
end
