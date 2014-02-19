class CreateUserTeamPairs < ActiveRecord::Migration
  def change
    create_table :user_team_pairs do |t|
      t.reference :user
      t.reference :team

      t.timestamps
    end
  end
end
