class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.references :game, index: true

      t.timestamps
    end
  end
end
