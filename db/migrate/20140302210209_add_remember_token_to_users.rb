class AddRememberTokenToUsers < ActiveRecord::Migration
	#add a remember me token to the database
	#this keeps a user signed in until they sign out
  def change
		add_column :users, :remember_token, :string
		add_index :users, :remember_token
  end
end
