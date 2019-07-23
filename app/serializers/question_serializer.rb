class QuestionSerializer < ActiveModel::Serializer
  # Use the attributes method to specify which methods of a model to include in the serialization output
  # All columns of a model have a corresponding getter method. 

  # rails g serializer question

  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :view_count,
    :like_count
  ) 

  # To include associated models, use the same named methods for creating associations.
  # You can rename the association with 'key:' which is only to show in the rendered json.
  belongs_to(:user, key: :author)
  has_many :answers

  # you can create methods inside a serializer to include custom data in the json serialization.
  # When doing so, make sure to include the name of the method in the attributes call.
  def like_count
    # 'object' will refer to the instance of the model being serialized. Use it where you would use 'self' in the model class.
    object.likes.count
  end

  class AnswerSerializer < ActiveModel::Serializer
    attributes :id, :body, :created_at, :updated_at

    belongs_to :user, key: :author
  end
end
