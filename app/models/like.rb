class Like < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :question_id, uniqueness: {scope: :user_id}
  # we cannot like the same question_id with the same user_id
  # this also validates user can also like many questions
end
