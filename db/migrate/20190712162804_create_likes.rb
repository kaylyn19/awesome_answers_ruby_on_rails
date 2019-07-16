class CreateLikes < ActiveRecord::Migration[5.2]
  # rails g model like question:references user:references
  def change
    create_table :likes do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
