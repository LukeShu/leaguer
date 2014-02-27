class CreateGameAttributes < ActiveRecord::Migration
  def change
    create_table :game_attributes do |t|
      t.references :game, index: true
      t.text :key
      t.integer :type

      t.timestamps
    end
  end
end
