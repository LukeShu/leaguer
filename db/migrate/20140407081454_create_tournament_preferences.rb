class CreateTournamentPreferences < ActiveRecord::Migration
  def change
    create_table :tournament_preferences do |t|
      t.references :tournament, index: true
      t.integer :vartype
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
