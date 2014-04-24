class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true
      t.string :token

      t.timestamps
    end
    add_index :sessions, :token, unique: true
  end
end
