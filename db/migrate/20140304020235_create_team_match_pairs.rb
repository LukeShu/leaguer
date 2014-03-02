class CreateTeamMatchPairs < ActiveRecord::Migration
  def change
    create_table :team_match_pairs do |t|
      t.references :team, index: true
      t.references :match, index: true

      t.timestamps
    end
  end
end
