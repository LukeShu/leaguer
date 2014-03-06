class CreateTournamentUserPairs < ActiveRecord::Migration
  def change
    create_table :tournament_user_pairs do |t|
      t.references :tournament, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
