class AddIndexToUsersUserName < ActiveRecord::Migration
 
# ensures that the username is unique
  def change
	add_index :users, :user_name, unique: true
  end
end
