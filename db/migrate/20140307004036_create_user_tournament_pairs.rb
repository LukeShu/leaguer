class CreateUserTournamentPairs < ActiveRecord::Migration
  def change
    create_table :user_tournament_pairs do |t|
      t.references :user, index: true
      t.references :tournament, index: true

      t.timestamps
    end
  end
end
