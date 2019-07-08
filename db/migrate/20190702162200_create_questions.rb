class CreateQuestions < ActiveRecord::Migration[5.2]
  def change #populates data
    create_table :questions do |t|
      t.string :title
      t.text :body

      t.timestamps
      # this will create two columns, "created_at" and "updated_at" which will auto-update
      # to migrate the file, run 'rails db:migrate'

      # to look at the status of migrations (whether they are active or not) do:
      # rails db:migrate:status

      # To reverse the last migration, do: rails db:rollback
    end
  end
end
