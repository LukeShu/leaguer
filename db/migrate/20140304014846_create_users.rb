class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.text :pw_hash
      t.integer :groups

      t.timestamps
    end
  end
end
