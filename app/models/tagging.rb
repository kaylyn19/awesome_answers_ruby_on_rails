class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :question

  validates :tag_id, uniqueness: {scope: :question_id}
  # each tag can only applied to a question once
end
