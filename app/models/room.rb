class Room < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :answers
end
