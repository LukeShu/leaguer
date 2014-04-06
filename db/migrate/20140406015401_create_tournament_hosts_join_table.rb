class CreateTournamentHostsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :hosts, :tournaments do |t|
      # t.index [:host_id, :tournament_id]
      # t.index [:tournament_id, :host_id]
    end
  end
end
