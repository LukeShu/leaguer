class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :status
      t.references :tournament_stage, index: true
      t.references :winner, index: true
      t.text :remote_id
      t.integer :submitted_peer_evaluations

      t.timestamps
    end
  end
end
