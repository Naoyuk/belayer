class Post < ApplicationRecord
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :user

  enum kind_of_climbing: {
    trad: 0,
    sport: 1,
    bouldering: 2,
    multi_pitches: 3
  }
end
