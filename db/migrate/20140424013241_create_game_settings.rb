class CreateGameSettings < ActiveRecord::Migration
  def change
    create_table :game_settings do |t|
      t.references :game, index: true
      t.string :name
      t.integer :vartype
      t.text :type_opt
      t.text :description
      t.integer :display_order
      t.text :default
      t.references :parent, index: true

      t.timestamps
    end
  end
end
