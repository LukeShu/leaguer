class CreateGameOptions < ActiveRecord::Migration
  def change
    create_table :game_options do |t|
      t.integer :vartype
      t.string :name
      t.text :default

      t.timestamps
    end
  end
end
