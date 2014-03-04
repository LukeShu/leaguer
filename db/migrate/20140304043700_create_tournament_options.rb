class CreateTournamentOptions < ActiveRecord::Migration
  def change
    create_table :tournament_options do |t|

      t.timestamps
    end
  end
end
