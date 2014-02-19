class CreateTeamMatchPairs < ActiveRecord::Migration
  def change
    create_table :team_match_pairs do |t|
      t.reference :team
      t.reference :match

      t.timestamps
    end
  end
end
