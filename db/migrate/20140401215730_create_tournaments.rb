class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.references :game, index: true
      t.integer :status
      t.boolean :randomized_teams

      t.timestamps
    end
  end
end
