class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :name
      t.integer :players_per_team
      t.integer :teams_per_match
      t.integer :set_rounds
      t.integer :randomized_teams

      t.timestamps
    end
  end
end
