class CreateTournamentStages < ActiveRecord::Migration
  def change
    create_table :tournament_stages do |t|
      t.references :tournament, index: true
      t.text :structure
      t.string :scheduling_method
      t.string :seeding_method

      t.timestamps
    end
  end
end
