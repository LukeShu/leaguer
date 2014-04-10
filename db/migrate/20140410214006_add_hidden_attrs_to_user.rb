class AddHiddenAttrsToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :permissions, :integer
  end
end
