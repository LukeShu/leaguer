class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :match, index: true

      t.timestamps
    end
  end
end
