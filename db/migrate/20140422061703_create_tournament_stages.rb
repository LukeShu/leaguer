class CreateTournamentStages < ActiveRecord::Migration
  def change
    create_table :tournament_stages do |t|
      t.references :tournament, index: true
      t.string :scheduling
      t.text :structure

      t.timestamps
    end
  end
end
