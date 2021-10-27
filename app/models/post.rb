class Post < ApplicationRecord
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :owner, class_name: 'User'
end
