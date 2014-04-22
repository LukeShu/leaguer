class CreateTournamentSettings < ActiveRecord::Migration
  def change
    create_table :tournament_settings do |t|
      t.references :tournament, index: true
      t.string :name
      t.integer :vartype
      t.text :type_opt
      t.text :description
      t.integer :display_order
      t.text :value

      t.timestamps
    end
  end
end
