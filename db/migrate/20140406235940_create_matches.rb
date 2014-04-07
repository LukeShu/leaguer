class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :status
      t.references :tournament, index: true
      t.string :name
      t.references :winner, index: true
      t.string :remote_id

      t.timestamps
    end
  end
end
