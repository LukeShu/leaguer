class AddIndexToUsersEmail < ActiveRecord::Migration

# adding unique: true ensures there can be no duplicates
  def change
	add_index :users, :email, unique: true
  end

end
