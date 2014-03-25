class CreateGameSettings < ActiveRecord::Migration
  def change
    create_table :game_settings do |t|
      t.references :game, index: true
      t.integer :type
      t.string :name
      t.text :default
      t.text :discription
      t.text :type_opt
      t.integer :display_order

      t.timestamps
    end
  end
end