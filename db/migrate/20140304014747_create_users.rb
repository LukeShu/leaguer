class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.varchar :pw_hash
      t.int :groups

      t.timestamps
    end
  end
end
