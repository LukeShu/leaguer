class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :parent, index: true
      t.string :name
      t.integer :min_players_per_team
      t.integer :max_players_per_team
      t.integer :min_teams_per_match
      t.integer :max_teams_per_match
      t.string :scoring_method

      t.timestamps
    end
    add_index :games, :name, unique: true
  end
end
