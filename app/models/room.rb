class Room < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true

  has_many :answers
end
