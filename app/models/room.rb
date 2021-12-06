class Room < ApplicationRecord
  belongs_to :post
  # belongs_to :user, optional: true
  belongs_to :host, class_name: "User", foreign_key: "host_user_id", optional: true
  belongs_to :answerer, class_name: "User", foreign_key: "answerer_user_id", optional: true

  has_many :answers
end
