class CreateGameSettings < ActiveRecord::Migration
  def change
    create_table :game_settings do |t|
      t.references :game, index: true
      t.integer :stype
      t.string :name
      t.text :default
      t.text :description
      t.text :type_opt
      t.integer :display_order

      t.timestamps
    end
  end
end
