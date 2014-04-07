class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.integer :default_user_permissions

      t.timestamps
    end
  end
end
