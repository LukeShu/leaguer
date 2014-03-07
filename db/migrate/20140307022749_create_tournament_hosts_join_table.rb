class CreateTournamentHostsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :tournaments do |t|
      # t.index [:user_id, :tournament_id]
      # t.index [:tournament_id, :user_id]
    end
  end
end
