class CreateUserTeamPairs < ActiveRecord::Migration
  def change
    create_table :user_team_pairs do |t|
      t.references :user, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
