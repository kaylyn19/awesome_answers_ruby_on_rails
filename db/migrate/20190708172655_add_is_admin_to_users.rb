class AddIsAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    # rails g migration add_is_admin_to_users is_admin:boolean
    add_column :users, :is_admin, :boolean, default: false
    # have a default in the boolean field
  end
end
