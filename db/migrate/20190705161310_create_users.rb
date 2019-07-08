class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    # generated by running : rails g model user first_name last_name email password_digest
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true} # uniquess constraint in db level, rather than at the model level
      # Add an index to columns that you query often
      # It will improve the performance of the query significantly as it grows in size
      # An index achieves this by creating an ordered list (a binary tree, technicially) that gives the db a faster way to search for values in that column.
      t.string :password_digest

      t.timestamps
    end
    # if you needed to add it to an existing table:
    # add_index :users, :email, unique: true

  end
end
