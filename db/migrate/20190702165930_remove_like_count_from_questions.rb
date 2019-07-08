class RemoveLikeCountFromQuestions < ActiveRecord::Migration[5.2]
  def change
    # to remove a column, do:
    # rails g migration remove_like_count_from_questions like_count:integer
    remove_column :questions, :like_count, :integer
  end
end
