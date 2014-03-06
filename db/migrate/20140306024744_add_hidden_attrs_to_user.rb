class AddHiddenAttrsToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_token, :string
    add_index :users, :remember_token, unique: true
    add_column :users, :groups, :integer
  end
end
