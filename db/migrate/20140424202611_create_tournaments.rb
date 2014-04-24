class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.references :game, index: true
      t.integer :status
      t.string :name
      t.integer :min_players_per_team
      t.integer :max_players_per_team
      t.integer :min_teams_per_match
      t.integer :max_teams_per_match
      t.integer :set_rounds
      t.boolean :randomized_teams
      t.string :sampling_method

      t.timestamps
    end
    add_index :tournaments, :name, unique: true
  end
end