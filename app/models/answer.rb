class Answer < ApplicationRecord
  validates :body, presence: true

  belongs_to :post
  belongs_to :user

  def unread
    self.read = false
    self.save!
  end

  # Check if this answer is the first answer
  # ==== parameters
  # * +post_id+ - Post you answer
  # * +user_id+ - Your user id
  # * +thread_id+ - This thread's id
  def first_answer?(post_id: nil, user_id: nil, thread_id: nil)
    # Return false if thread_id already exists. This means this is not a new answer.
    return false if thread_id
    # Return true if there is no Answer with the post_id and user_id passed as arguments.
    # This means this is a new answer.
    post = Post.find(post_id)
    !Answer.find_by(post_id: post_id, user_id: user_id)
  end
end
